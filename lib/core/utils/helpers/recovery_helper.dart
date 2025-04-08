import 'dart:io';

import 'package:drift/drift.dart';
import 'package:file_picker/file_picker.dart';
import 'package:momentum_track/core/constant/app_constant.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/locator.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart' hide Row;

class RecoveryHelper {
  RecoveryHelper._();

  static Future<void> createDatabaseBackup(
    DatabaseConnectionUser database,
  ) async {
    final chosenDirectory = await FilePicker.platform.getDirectoryPath();
    if (chosenDirectory == null) return;

    final String fileName =
        'momentum_${DateTime.now().toIso8601String()}_${AppConstant.dbSchemaVersion}.sqlite';
    final parent = Directory(chosenDirectory);
    final file = File(join(chosenDirectory, fileName));

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

  static Future<void> restoreDatabase() async {
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
  }
}
