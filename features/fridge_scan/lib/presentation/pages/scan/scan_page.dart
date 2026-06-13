import 'dart:io';

import 'package:core/components/ai_loader/app_ai_loader.dart';
import 'package:core/components/empty_state/app_empty_state.dart';
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

import '../../../domain/entities/ingredient_entity.dart';
import '../../../domain/entities/scan_entity.dart';
import '../../../domain/entities/scan_result_entity.dart';
import '../../../fridge_scan_routes.dart';
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

  // A scan failure stays on this page as a full-screen error state (see
  // `_ScanError`); only success navigates away, so the listener handles just
  // that transition.
  void _onScanSucceeded(BuildContext context, ScanState state) {
    if (state.scanState != BlocStatus.success) return;
    final ScanEntity? scan = state.scanResponse;
    if (scan == null) return;
    // Hand the detected ingredients to the review step, replacing the preview
    // so backing out of review returns home, not to the photo.
    IngredientReviewRoute(
      $extra: ScanResultEntity(
        scan: scan,
        ingredients: state.ingredientsResponse ?? <IngredientEntity>[],
      ),
    ).pushReplacement(context);
  }

  /// Discards the current photo and re-opens the source sheet so the user can
  /// capture a clearer one after a failed scan.
  void _chooseAnotherPhoto() {
    context.read<ScanBloc>().add(const ScanEvent.retaken());
    _promptForSource();
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
            listenWhen: (ScanState p, ScanState c) => p.pickStatus != c.pickStatus,
            listener: _onPickStatusChanged,
          ),
          BlocListener<ScanBloc, ScanState>(
            listenWhen: (ScanState p, ScanState c) => p.scanState != c.scanState,
            listener: _onScanSucceeded,
          ),
        ],
        child: SafeArea(
          child: BlocBuilder<ScanBloc, ScanState>(
            builder: (BuildContext context, ScanState state) {
              // The Gemini vision moment: a labelled loader, never a bare
              // spinner (PRD §1.4 / §7.1).
              if (state.scanState == BlocStatus.loading) {
                return const AppAiLoader(
                  title: 'Reading your fridge…',
                  subtitle: 'AI vision is identifying ingredients in your photo.',
                  icon: Icons.psychology_rounded,
                );
              }
              if (state.scanState == BlocStatus.error) {
                return _ScanError(
                  message: state.scanFailure?.message,
                  onTryAgain: () => context.read<ScanBloc>().add(
                    const ScanEvent.confirmed(),
                  ),
                  onChooseAnother: _chooseAnotherPhoto,
                );
              }
              final XFile? image = state.pickedImage;
              if (image != null) {
                return _ScanPreview(
                  image: image,
                  onRetake: () => context.read<ScanBloc>().add(
                    const ScanEvent.retaken(),
                  ),
                  onConfirm: () => context.read<ScanBloc>().add(
                    const ScanEvent.confirmed(),
                  ),
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

/// Full-screen preview of the captured photo with retake/confirm actions.
class _ScanPreview extends StatelessWidget {
  const _ScanPreview({
    required this.image,
    required this.onRetake,
    required this.onConfirm,
  });

  final XFile image;
  final VoidCallback onRetake;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.s5),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceInverse,
                borderRadius: const BorderRadius.all(AppRadius.brLg),
                image: DecorationImage(
                  image: FileImage(File(image.path)),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        _PreviewActions(
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
    required this.onRetake,
    required this.onConfirm,
  });

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
              onPressed: onRetake,
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
              onPressed: onConfirm,
              icon: const Icon(Icons.auto_awesome_rounded),
              label: const Text('Confirm'),
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

/// Full-screen scan-failure state (PRD §1.7, covering risks R1/R3): a calm
/// coral alert, the reason, and a way to retry or pick a different photo.
///
/// Failures abort before any upload or persistence (see
/// `FridgeScanRepositoryImpl.scanFridge`), so we can promise the user nothing
/// was saved and no quota was spent — blame the photo conditions, never them.
class _ScanError extends StatelessWidget {
  const _ScanError({
    required this.message,
    required this.onTryAgain,
    required this.onChooseAnother,
  });

  /// The failure's user-facing reason; falls back to generic guidance.
  final String? message;
  final VoidCallback onTryAgain;
  final VoidCallback onChooseAnother;

  static const double _iconCircle = 88;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.s8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: _iconCircle,
              height: _iconCircle,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.dangerTint,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                size: AppSpacing.s9,
                color: AppColors.danger,
              ),
            ),
            const SizedBox(height: AppSpacing.s5),
            Text(
              "We couldn't read that photo",
              textAlign: TextAlign.center,
              style: context.textTheme.displaySmall,
            ),
            const SizedBox(height: AppSpacing.s2),
            Text(
              message ??
                  'We couldn\'t find any ingredients. Try better lighting, '
                      'or step back so more of the fridge is visible.',
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
            ),
            const SizedBox(height: AppSpacing.s6),
            FilledButton.icon(
              onPressed: onTryAgain,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try again'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(AppLayout.tapTarget),
              ),
            ),
            const SizedBox(height: AppSpacing.s2),
            TextButton.icon(
              onPressed: onChooseAnother,
              icon: const Icon(Icons.photo_library_outlined),
              label: const Text('Choose another photo'),
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(AppLayout.tapTarget),
                foregroundColor: AppColors.textBody,
              ),
            ),
            const SizedBox(height: AppSpacing.s4),
            Text(
              "Your photo wasn't saved · no quota used",
              textAlign: TextAlign.center,
              style: AppTypography.mono.copyWith(
                fontSize: AppTextSize.xs,
                color: AppColors.textFaint,
              ),
            ),
          ],
        ),
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
        child: AppEmptyState(
          icon: Icons.photo_camera_back_rounded,
          title: 'Add a fridge photo',
          message: 'Take or choose a photo to start detecting ingredients.',
          actionLabel: 'Add a photo',
          actionIcon: Icons.add_a_photo_rounded,
          onAction: onAddPhoto,
          padding: EdgeInsets.zero,
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
