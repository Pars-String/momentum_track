import 'dart:io';

import 'package:drift/drift.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/locator.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart' hide Row;

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
            // Close existing database
            final oldDb = locator<AppDatabase>();
            await oldDb.close();

            // Open the selected database file
            final backupFile = await FilePicker.platform.pickFiles();
            if (backupFile == null) return;
            final backupDb = sqlite3.open(backupFile.files.single.path!);

            // Vacuum it into a temporary location first to make sure it's working.
            final tempPath = await getTemporaryDirectory();
            final tempDb = join(tempPath.path, 'import.db');
            backupDb
              ..execute('VACUUM INTO ?', [tempDb])
              ..dispose();

            // Then replace the existing database file with it.
            final tempDbFile = File(tempDb);
            await tempDbFile.copy((await databaseFile).path);
            await tempDbFile.delete();

            // And now, re-open the database!
            // await locator.resetLazySingleton<AppDatabase>(
            //   instance: AppDatabase(), // New instance
            //   disposingFunction: (oldDb) => oldDb.close(),
            // );
          },
          icon: Icon(Icons.cloud_download_rounded),
        ),
        IconButton(
          onPressed: () {
            createDatabaseBackup(locator<AppDatabase>());
          },
          icon: Icon(Icons.cloud_upload_outlined),
        ),
        Spacer(),
      ],
    );
  }
}

Future<void> createDatabaseBackup(DatabaseConnectionUser database) async {
  final choosenDirectory = await FilePicker.platform.getDirectoryPath();
  if (choosenDirectory == null) return;

  final parent = Directory(choosenDirectory);
  final file = File(join(choosenDirectory, 'momentum_db.sqlite'));

  // Make sure the directory of the file exists
  if (!await parent.exists()) {
    await parent.create(recursive: true);
  }
  // However, the file itself must not exist
  if (await file.exists()) {
    await file.delete();
  }

  await database.customStatement('VACUUM INTO ?', [file.absolute.path]);
}
