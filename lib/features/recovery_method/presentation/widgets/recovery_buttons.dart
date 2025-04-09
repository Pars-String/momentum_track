import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/utils/helpers/recovery_helper.dart';
import 'package:momentum_track/locator.dart';

class RecoveryButtons extends StatelessWidget {
  const RecoveryButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(18),
        IconButton(
          onPressed: () async {
            await RecoveryHelper.restoreDatabase();
          },
          icon: Icon(Icons.cloud_download_rounded),
          tooltip: 'Restore from backup',
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
        ),
        IconButton(
          onPressed: () async {
            await RecoveryHelper.createDatabaseBackup(locator<AppDatabase>());
          },
          tooltip: 'Create backup',
          icon: Icon(Icons.cloud_upload_outlined),
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
        ),
        Spacer(),
      ],
    );
  }
}
