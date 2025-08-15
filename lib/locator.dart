import 'package:get_it/get_it.dart';
import 'package:momentum_track/core/data/services/database_service.dart';
import 'package:momentum_track/core/data/services/global_date_service.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/repositories/global_repository.dart';
import 'package:momentum_track/features/date_details/data/date_details_local_provider.dart';
import 'package:momentum_track/features/date_details/repository/date_details_repository.dart';
import 'package:momentum_track/features/month_overview/data/overview_local_provider.dart';
import 'package:momentum_track/features/month_overview/repository/overview_repository.dart';
import 'package:momentum_track/features/project_details/data/project_details_local_provider.dart';
import 'package:momentum_track/features/project_details/repository/project_details_repository.dart';
import 'package:momentum_track/features/projects/data/projects_local_provider.dart';
import 'package:momentum_track/features/projects/data/projects_service.dart';
import 'package:momentum_track/features/projects/repository/projects_repository.dart';
import 'package:momentum_track/features/reports/data/reports_local_provider.dart';
import 'package:momentum_track/features/reports/repository/reports_repository.dart';
import 'package:momentum_track/features/streak_tracker/data/providers/streak_local_provider.dart';
import 'package:momentum_track/features/streak_tracker/data/services/streak_date_service.dart';
import 'package:momentum_track/features/streak_tracker/repository/streak_repository.dart';

GetIt locator = GetIt.instance;

Future<void> locatorSetup() async {
  _callServices();
  _callProviders();
  _callRepositories();
}

void _callProviders() {
  locator.registerSingleton<OverviewLocalProvider>(
    OverviewLocalProvider(locator()),
  );
  locator.registerSingleton<ProjectsLocalProvider>(
    ProjectsLocalProvider(locator()),
  );
  locator.registerSingleton<ProjectDetailsLocalProvider>(
    ProjectDetailsLocalProvider(locator()),
  );
  locator.registerSingleton<DateDetailsLocalProvider>(
    DateDetailsLocalProvider(locator()),
  );
  locator.registerSingleton<ReportsLocalProvider>(
    ReportsLocalProvider(locator()),
  );
  locator.registerSingleton<StreakLocalProvider>(
    StreakLocalProvider(locator()),
  );
}

void _callServices() {
  final database = locator.registerSingleton<AppDatabase>(AppDatabase());

  locator.registerSingleton<DatabaseService>(DatabaseService(database));
  locator.registerSingleton<StreakDateService>(StreakDateService());
  locator.registerSingleton<ProjectsService>(ProjectsService());
  locator.registerSingleton<GlobalDateService>(GlobalDateService());
}

void _callRepositories() {
  locator.registerSingleton<OverviewRepository>(
    OverviewRepository(locator(), locator()),
  );
  locator.registerSingleton<ProjectsRepository>(
    ProjectsRepository(locator(), locator(), locator()),
  );
  locator.registerSingleton<ReportsRepository>(
    ReportsRepository(locator(), locator()),
  );
  locator.registerSingleton<StreakRepository>(
    StreakRepository(locator(), locator()),
  );
  locator.registerSingleton<ProjectDetailsRepository>(
    ProjectDetailsRepository(locator()),
  );
  locator.registerSingleton<DateDetailsRepository>(
    DateDetailsRepository(locator()),
  );
  locator.registerSingleton<GlobalRepository>(GlobalRepository(locator()));
}
