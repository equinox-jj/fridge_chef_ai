import 'dart:io';

import 'package:core/components/snackbar/app_snackbar.dart';
import 'package:core/constants/bloc/bloc_status.dart';
import 'package:core/constants/image_source_option/image_source_option.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_font_family.dart';
import 'package:core/theme/app_layout.dart';
import 'package:core/theme/app_radius.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/go_router/go_router.dart';
import 'package:dependencies/image_picker/image_picker.dart';
import 'package:flutter/material.dart';

import '../../widgets/pick_image_source_sheet.dart';
import 'bloc/scan_bloc.dart';

/// Preview & confirm step of the fridge scan.
///
/// On entry it opens the photo-source sheet, resolves the capture permission
/// and shows the captured photo full-screen. Nothing is sent to the AI until
/// the user taps **Confirm** (PRD §4.2.2).
class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  void initState() {
    super.initState();
    // Open the source sheet immediately so reaching this page feels like a
    // single tap from the home FAB; the empty state stays as a fallback if the
    // sheet is dismissed.
    WidgetsBinding.instance.addPostFrameCallback((_) => _promptForSource());
  }

  /// Asks the user to choose a capture source, then hands the choice to the
  /// bloc to resolve permissions and open the picker.
  Future<void> _promptForSource() async {
    final ScanBloc bloc = context.read<ScanBloc>();
    final ImageSourceOption? source = await PickImageSourceSheet.openSheet(context);
    if (source == null) return;
    bloc.add(ScanEvent.sourceSelected(source));
  }

  void _onPickStatusChanged(BuildContext context, ScanState state) {
    if (state.pickStatus != ScanPickStatus.permissionDenied) {
      return;
    }
    final bool needsSettings = state.permission?.needsSettings ?? false;
    if (needsSettings) {
      _showSettingsDialog(context);
    } else {
      AppSnackbar.warning(
        context,
        'We need access to capture a photo of your fridge.',
        title: 'Permission needed',
      );
    }
  }

  void _onScanStatusChanged(BuildContext context, ScanState state) {
    switch (state.scanState) {
      case BlocStatus.error:
        AppSnackbar.error(
          context,
          state.scanFailure?.message ?? 'Something went wrong. Please try again.',
        );
        break;
      case BlocStatus.success:
        final int count = state.ingredientsResponse?.length ?? 0;
        AppSnackbar.success(
          context,
          'Found $count ingredient${count == 1 ? '' : 's'} in your fridge.',
        );
        break;
      default:
    }
  }

  Future<void> _showSettingsDialog(BuildContext context) async {
    final ScanBloc bloc = context.read<ScanBloc>();
    final bool? openSettings = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => const _PermissionDeniedDialog(),
    );
    if (openSettings ?? false) {
      bloc.add(const ScanEvent.settingsRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceCanvas,
      appBar: AppBar(
        title: Text(
          'Preview',
          style: context.textTheme.headlineMedium?.copyWith(
            fontFamily: AppFontFamily.display,
            fontWeight: AppFontWeight.bold,
          ),
        ),
      ),
      body: MultiBlocListener(
        listeners: <BlocListener<ScanBloc, ScanState>>[
          BlocListener<ScanBloc, ScanState>(
            listenWhen: (ScanState previous, ScanState current) => previous.pickStatus != current.pickStatus,
            listener: _onPickStatusChanged,
          ),
          BlocListener<ScanBloc, ScanState>(
            listenWhen: (ScanState previous, ScanState current) => previous.scanState != current.scanState,
            listener: _onScanStatusChanged,
          ),
        ],
        child: SafeArea(
          child: BlocBuilder<ScanBloc, ScanState>(
            builder: (BuildContext context, ScanState state) {
              final XFile? image = state.pickedImage;
              if (image != null) {
                return _ScanPreview(
                  image: image,
                  isScanning: state.scanState == BlocStatus.loading,
                  onRetake: () => context.read<ScanBloc>().add(const ScanEvent.retaken()),
                  onConfirm: () => context.read<ScanBloc>().add(const ScanEvent.confirmed()),
                );
              }
              if (state.pickStatus == ScanPickStatus.picking) {
                return const Center(child: CircularProgressIndicator());
              }
              return _PhotoPrompt(onAddPhoto: _promptForSource);
            },
          ),
        ),
      ),
    );
  }
}

/// Full-screen preview of the captured photo with retake/confirm actions and a
/// scanning overlay shown while the AI request is in flight.
class _ScanPreview extends StatelessWidget {
  const _ScanPreview({
    required this.image,
    required this.isScanning,
    required this.onRetake,
    required this.onConfirm,
  });

  final XFile image;
  final bool isScanning;
  final VoidCallback onRetake;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.s5),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(AppRadius.brLg),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  ColoredBox(
                    color: AppColors.surfaceInverse,
                    child: Image.file(
                      File(image.path),
                      fit: BoxFit.contain,
                    ),
                  ),
                  if (isScanning) const _ScanningOverlay(),
                ],
              ),
            ),
          ),
        ),
        _PreviewActions(
          isScanning: isScanning,
          onRetake: onRetake,
          onConfirm: onConfirm,
        ),
      ],
    );
  }
}

/// The retake / confirm action bar pinned below the preview.
class _PreviewActions extends StatelessWidget {
  const _PreviewActions({
    required this.isScanning,
    required this.onRetake,
    required this.onConfirm,
  });

  final bool isScanning;
  final VoidCallback onRetake;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.s5,
        AppSpacing.s0,
        AppSpacing.s5,
        AppSpacing.s5,
      ),
      child: Row(
        spacing: AppSpacing.s3,
        children: <Widget>[
          Expanded(
            child: OutlinedButton.icon(
              onPressed: isScanning ? null : onRetake,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retake'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(AppLayout.tapTarget),
                foregroundColor: AppColors.textPrimary,
                backgroundColor: AppColors.surfaceCard,
                side: const BorderSide(color: AppColors.borderStrong),
              ),
            ),
          ),
          Expanded(
            child: FilledButton.icon(
              onPressed: isScanning ? null : onConfirm,
              icon: isScanning ? const SizedBox.shrink() : const Icon(Icons.auto_awesome_rounded),
              label: isScanning
                  ? const SizedBox(
                      width: AppSpacing.s5,
                      height: AppSpacing.s5,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: AppColors.onPrimary,
                      ),
                    )
                  : const Text('Confirm'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(AppLayout.tapTarget),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Translucent scrim shown over the preview while Gemini analyses the photo.
class _ScanningOverlay extends StatelessWidget {
  const _ScanningOverlay();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.surfaceInverse.withValues(alpha: 0.6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: AppSpacing.s4,
        children: <Widget>[
          const SizedBox(
            width: AppSpacing.s8,
            height: AppSpacing.s8,
            child: CircularProgressIndicator(color: AppColors.textInverse),
          ),
          Text(
            'Scanning your fridge…',
            style: context.textTheme.titleMedium?.copyWith(
              color: AppColors.textInverse,
              fontWeight: AppFontWeight.semiBold,
            ),
          ),
          Text(
            'Detecting ingredients with AI',
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.textInverse.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

/// Empty state shown when no photo has been captured yet, with a button to
/// re-open the source sheet.
class _PhotoPrompt extends StatelessWidget {
  const _PhotoPrompt({required this.onAddPhoto});

  final VoidCallback onAddPhoto;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpacing.s4,
          children: <Widget>[
            const Icon(
              Icons.photo_camera_back_rounded,
              size: AppTextSize.display,
              color: AppColors.textFaint,
            ),
            Text(
              'Add a fridge photo',
              style: context.textTheme.titleMedium,
            ),
            Text(
              'Take or choose a photo to start detecting ingredients.',
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: AppSpacing.s2),
            FilledButton.icon(
              onPressed: onAddPhoto,
              icon: const Icon(Icons.add_a_photo_rounded),
              label: const Text('Add a photo'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(AppLayout.tapTarget),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Dialog shown when a permission is permanently denied, pointing the user to
/// the OS app settings to grant it.
class _PermissionDeniedDialog extends StatelessWidget {
  const _PermissionDeniedDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Permission needed'),
      content: const Text(
        'Capturing a fridge photo needs camera and photo access. Turn it on in '
        'Settings to continue.',
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => context.pop(false),
          child: const Text('Not now'),
        ),
        FilledButton(
          onPressed: () => context.pop(true),
          child: const Text('Open settings'),
        ),
      ],
    );
  }
}
