import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:momentum_track/core/data/services/database_service.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart' hide Row;

class ManageDbHelper {
  final DatabaseService dbService;
  ManageDbHelper(this.dbService);

  Future<bool> createDatabaseBackup() async {
    return await dbService.createDatabaseBackup();
  }

  Future<bool> restoreDatabase() async {
    // Open the selected database file
    final backupFile = await FilePicker.platform.pickFiles();
    if (backupFile == null) return false;
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
    return true;
  }

  Future<void> clearDatabase() async {
    await dbService.clearDatabase();
  }
}
