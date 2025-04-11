import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:momentum_track/core/widgets/app_elevated_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Theme.of(context).colorScheme.primary),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Database Settings',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Gap(8),
                Row(
                  children: [
                    AppElevatedButton(
                      onPressed: () {},
                      title: 'Restore Database',
                      icon: HugeIcons.strokeRoundedDataRecovery,
                    ),
                    Gap(8),
                    AppElevatedButton(
                      onPressed: () {},
                      title: 'Create Backup',
                      icon: HugeIcons.strokeRoundedDatabaseExport,
                    ),
                    Gap(8),
                    AppElevatedButton(
                      onPressed: () {},
                      backgroundColor: Theme.of(context).colorScheme.error,
                      title: 'Delete All Data',
                      icon: HugeIcons.strokeRoundedFolderRemove,
                    ),
                  ],
                ),
                Gap(6),
              ],
            ),
          ),
        ),
        Gap(12),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Theme.of(context).colorScheme.primary),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Appearance Settings',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Gap(8),
                Row(
                  children: [
                    AppElevatedButton(
                      onPressed: () {},
                      title: 'Change Language',
                      icon: HugeIcons.strokeRoundedLanguageSkill,
                    ),
                    Gap(8),
                    AppElevatedButton(
                      onPressed: () {},
                      title: 'Change Theme',
                      icon: HugeIcons.strokeRoundedDarkMode,
                    ),
                  ],
                ),
                Gap(6),
              ],
            ),
          ),
        ),
        Gap(12),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Theme.of(context).colorScheme.primary),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact Me',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Gap(8),
                Row(
                  children: [
                    AppElevatedButton(
                      onPressed: () {},
                      title: 'Source Code',
                      icon: HugeIcons.strokeRoundedGithub01,
                    ),
                    Gap(8),
                    AppElevatedButton(
                      onPressed: () {},
                      title: 'My LinkedIn',
                      icon: HugeIcons.strokeRoundedLinkedin01,
                    ),
                  ],
                ),
                Gap(6),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
