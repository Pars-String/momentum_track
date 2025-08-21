import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/utils/helpers/recovery_helper.dart';
import 'package:momentum_track/core/widgets/app_elevated_button.dart';
import 'package:momentum_track/features/export/presentation/widgets/export_custom_date_report.dart';
import 'package:momentum_track/features/export/presentation/widgets/export_this_month_report.dart';
import 'package:momentum_track/features/settings/presentation/widgets/setting_box.dart';
import 'package:momentum_track/locator.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        SettingBox(
          title: 'Database Settings',
          child: Row(
            children: [
              AppElevatedButton(
                onPressed: () async {
                  await RecoveryHelper.restoreDatabase();
                },
                title: 'Restore Database',
                icon: HugeIcons.strokeRoundedDataRecovery,
              ),
              Gap(8),
              AppElevatedButton(
                onPressed: () async {
                  await RecoveryHelper.createDatabaseBackup(
                    locator<AppDatabase>(),
                  );
                },
                title: 'Create Backup',
                icon: HugeIcons.strokeRoundedDatabaseExport,
              ),
              // Gap(8),
              // AppElevatedButton(
              //   onPressed: () {},
              //   backgroundColor: Theme.of(context).colorScheme.error,
              //   title: 'Delete All Data',
              //   icon: HugeIcons.strokeRoundedFolderRemove,
              // ),
            ],
          ),
        ),

        Gap(12),
        SettingBox(
          title: 'Generate Report',
          child: Row(
            children: [
              ExportThisMonthReport(),
              Gap(8),
              ExportCustomDateReport(),
            ],
          ),
        ),

        // Gap(12),
        // SettingBox(
        //   title: 'Appearance Settings',
        //   child: Row(
        //     children: [
        //       AppElevatedButton(
        //         onPressed: () {},
        //         title: 'Change Language',
        //         icon: HugeIcons.strokeRoundedLanguageSkill,
        //       ),
        //       Gap(8),
        //       AppElevatedButton(
        //         onPressed: () {},
        //         title: 'Change Theme',
        //         icon: HugeIcons.strokeRoundedDarkMode,
        //       ),
        //     ],
        //   ),
        // ),

        // Gap(12),
        // SettingBox(
        //   title: 'Contact Me',
        //   child: Row(
        //     children: [
        //       AppElevatedButton(
        //         onPressed: () {},
        //         title: 'Source Code',
        //         icon: HugeIcons.strokeRoundedGithub01,
        //       ),
        //       Gap(8),
        //       AppElevatedButton(
        //         onPressed: () {},
        //         title: 'My LinkedIn',
        //         icon: HugeIcons.strokeRoundedLinkedin01,
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
