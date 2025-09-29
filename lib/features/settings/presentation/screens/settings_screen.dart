import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:momentum_track/core/l10n/generated/l10n.dart';
import 'package:momentum_track/core/widgets/app_elevated_button.dart';
import 'package:momentum_track/core/widgets/app_toastification.dart';
import 'package:momentum_track/features/generate_report/presentation/widgets/export_custom_date_report.dart';
import 'package:momentum_track/features/generate_report/presentation/widgets/export_this_month_report.dart';
import 'package:momentum_track/features/manage_database/presentation/widgets/backup_data_button.dart';
import 'package:momentum_track/features/manage_database/presentation/widgets/delete_all_data_button.dart';
import 'package:momentum_track/features/manage_database/presentation/widgets/recover_data_button.dart';
import 'package:momentum_track/features/settings/presentation/widgets/change_language_dialog_box.dart';
import 'package:momentum_track/features/settings/presentation/widgets/setting_box.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        SettingBox(
          title: S.current.settingsScreen_database_title,
          child: Row(
            children: [
              RecoverDataButton(),
              Gap(8),
              BackupDataButton(),
              Gap(8),
              DeleteAllDataButton(),
            ],
          ),
        ),

        Gap(12),
        SettingBox(
          title: S.current.settingsScreen_generateReport_title,
          child: Row(
            children: [
              ExportThisMonthReport(),
              Gap(8),
              ExportCustomDateReport(),
            ],
          ),
        ),

        Gap(12),
        SettingBox(
          title: S.current.settingsScreen_appSettings_title,
          child: Row(
            children: [
              AppElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ChangeLanguageDialogBox();
                    },
                  );
                },
                title: S.current.button_changeLanguage,
                icon: HugeIcons.strokeRoundedLanguageCircle,
              ),
              // Gap(8),
              // AppElevatedButton(
              //   onPressed: () {},
              //   title: 'Change Theme',
              //   icon: HugeIcons.strokeRoundedDarkMode,
              // ),
            ],
          ),
        ),
        Gap(12),
        SettingBox(
          title: S.current.settingsScreen_contact_title,
          child: Row(
            children: [
              AppElevatedButton(
                onPressed: () =>
                    _launchUrl('github.com/Pars-String/momentum_track/issues'),
                title: S.current.button_reportIssue,
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
                                  text:
                                      '${S.current.contactAndSupport_contactDialogBox_contents('line1')}\n',
                                ),
                                TextSpan(
                                  text:
                                      '${S.current.contactAndSupport_contactDialogBox_contents('line2')}\n',
                                ),
                                TextSpan(
                                  text:
                                      '${S.current.contactAndSupport_contactDialogBox_contents('line3')}\n',
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
                                        description: S
                                            .current
                                            .toast_copyEmailToClipboard,
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
                            child: Text(S.current.button_close),
                          ),
                        ],
                      );
                    },
                  );
                },
                title: S.current.button_contactInfo,
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
