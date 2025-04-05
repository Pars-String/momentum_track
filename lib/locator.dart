import 'package:get_it/get_it.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/services/database_service.dart';
import 'package:momentum_track/features/projects/data/projects_local_provider.dart';
import 'package:momentum_track/features/projects/repository/projects_repository.dart';

GetIt locator = GetIt.instance;

Future<void> locatorSetup() async {
  final database = AppDatabase();

  locator.registerSingleton<DatabaseService>(DatabaseService(database));

  locator.registerSingleton<ProjectsLocalProvider>(
    ProjectsLocalProvider(locator()),
  );
  locator.registerSingleton<ProjectsRepository>(ProjectsRepository(locator()));
}
