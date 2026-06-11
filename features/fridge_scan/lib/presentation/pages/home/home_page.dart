import 'package:core/components/section_header/app_section_header.dart';
import 'package:core/extensions/context_ext.dart';
import 'package:core/theme/app_colors.dart';
import 'package:core/theme/app_font_family.dart';
import 'package:core/theme/app_spacing.dart';
import 'package:core/theme/app_typography.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/scan_result_entity.dart';
import '../../widgets/home_greeting.dart';
import '../../widgets/pick_image_source_sheet.dart';
import '../../widgets/scan_fridge_card.dart';
import '../../widgets/scan_history_tile.dart';
import 'bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _openScanSheet(BuildContext context) => PickImageSourceSheet.openSheet(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: AppSpacing.s4,
        title: Text(
          'FridgeScan',
          style: context.textTheme.headlineMedium?.copyWith(
            fontFamily: AppFontFamily.display,
            fontWeight: AppFontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
            tooltip: 'Notifications',
          ),
          const SizedBox(width: AppSpacing.s2),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openScanSheet(context),
        tooltip: 'Scan your fridge',
        child: const Icon(Icons.photo_camera_rounded),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (BuildContext context, HomeState state) {
          return SafeArea(
            top: false,
            child: SingleChildScrollView(
              // Extra bottom padding keeps the last row clear of the FAB.
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.s5,
                AppSpacing.s2,
                AppSpacing.s5,
                AppSpacing.s12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: AppSpacing.s6,
                children: <Widget>[
                  HomeGreeting(name: state.userProfile?.name),
                  ScanFridgeCard(onTap: () => _openScanSheet(context)),
                  _RecentScansSection(scans: state.recentScans),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// "Recent scans" heading plus the list of past scans, or a friendly empty
/// state when the user hasn't scanned anything yet.
class _RecentScansSection extends StatelessWidget {
  const _RecentScansSection({required this.scans});

  final List<ScanResultEntity> scans;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSpacing.s3,
      children: <Widget>[
        const AppSectionHeader(title: 'Recent scans'),
        if (scans.isEmpty)
          const _EmptyRecentScans()
        else
          ...scans.map((ScanResultEntity scan) => ScanHistoryTile(scan: scan)),
      ],
    );
  }
}

class _EmptyRecentScans extends StatelessWidget {
  const _EmptyRecentScans();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s8),
      child: Column(
        spacing: AppSpacing.s3,
        children: <Widget>[
          const Icon(
            Icons.history_rounded,
            size: AppTextSize.display,
            color: AppColors.textFaint,
          ),
          Text(
            'No scans yet',
            style: context.textTheme.titleMedium,
          ),
          Text(
            'Scan your fridge to see your results here.',
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
