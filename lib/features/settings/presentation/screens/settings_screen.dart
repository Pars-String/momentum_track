import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/utils/helpers/recovery_helper.dart';
import 'package:momentum_track/core/widgets/app_elevated_button.dart';
import 'package:momentum_track/core/widgets/app_toastification.dart';
import 'package:momentum_track/features/export/presentation/widgets/export_custom_date_report.dart';
import 'package:momentum_track/features/export/presentation/widgets/export_this_month_report.dart';
import 'package:momentum_track/features/settings/presentation/widgets/setting_box.dart';
import 'package:momentum_track/locator.dart';
import 'package:url_launcher/url_launcher.dart';

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
        Gap(12),
        SettingBox(
          title: 'Contact & Support',
          child: Row(
            children: [
              AppElevatedButton(
                onPressed: () =>
                    _launchUrl('github.com/Pars-String/momentum_track/issues'),
                title: 'Report an Issue',
                icon: HugeIcons.strokeRoundedBug02,
              ),
              Gap(8),
              AppElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        contentPadding: const EdgeInsets.all(16),
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Help us make this app better!\n',
                                ),
                                TextSpan(
                                  text:
                                      'Share your thoughts, report problems, or suggest new features.\n',
                                ),
                                TextSpan(
                                  text:
                                      'You can contact us anytime via email or send me a message on LinkedIn.\n',
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  _launchUrl(
                                    'www.linkedin.com/in/mahdiyar-arbabzi/',
                                  );
                                },
                                icon: Icon(HugeIcons.strokeRoundedLinkedin01),
                              ),
                              IconButton(
                                onPressed: () {
                                  _launchUrl('github.com/mahdiyarz');
                                },
                                icon: Icon(HugeIcons.strokeRoundedGithub01),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await FlutterClipboard.copy(
                                    'm.arbabzi@gmail.com',
                                  ).then((value) {
                                    if (context.mounted) {
                                      AppToastification.showInfo(
                                        context,
                                        description:
                                            'Email address copied to clipboard.',
                                      );
                                    }
                                  });
                                },
                                icon: Icon(HugeIcons.strokeRoundedMail02),
                              ),
                            ],
                          ),
                          Gap(20),
                          TextButton(
                            onPressed: () => context.pop(),
                            child: Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
                title: 'Contact Info',
                icon: HugeIcons.strokeRoundedContact,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    final parseUri = Uri.parse("https://$url");
    if (!await canLaunchUrl(parseUri)) return;
    if (!await launchUrl(parseUri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
