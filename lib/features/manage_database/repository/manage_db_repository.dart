import 'package:momentum_track/features/manage_database/date/helpers/manage_db_helper.dart';

class ManageDbRepository {
  final ManageDbHelper _dbHelper;

  ManageDbRepository(this._dbHelper);

  Future<bool> createDatabaseBackup() async {
    return await _dbHelper.createDatabaseBackup();
  }

  Future<bool> restoreDatabase() async {
    return await _dbHelper.restoreDatabase();
  }

  Future<void> clearDatabase() async {
    await _dbHelper.clearDatabase();
  }
}
