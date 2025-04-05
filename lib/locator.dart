import 'package:get_it/get_it.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/services/database_service.dart';

GetIt locator = GetIt.instance;

Future<void> locatorSetup() async {
  final database = AppDatabase();

  locator.registerSingleton<DatabaseService>(DatabaseService(database));
}
