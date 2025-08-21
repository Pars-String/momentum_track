import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:momentum_track/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:momentum_track/features/date_details/presentation/bloc/date_details_bloc.dart';
import 'package:momentum_track/features/date_details/presentation/screens/date_details_screen.dart';
import 'package:momentum_track/features/main/presentation/screens/main_screen.dart';
import 'package:momentum_track/features/project_details/presentation/bloc/details_bloc.dart';
import 'package:momentum_track/features/project_details/presentation/screens/project_details_screen.dart';
import 'package:momentum_track/features/projects/presentation/bloc/projects_bloc.dart';
import 'package:momentum_track/locator.dart';
import 'package:momentum_track/main.dart';

class AppRoutes {
  static const String mainScreen = 'mainScreen';
  static const String projectDetailsScreen = 'projectDetailsScreen';
  static const String dateDetailsScreen = 'dateDetailsScreen';

  static GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: kDebugMode,
    initialLocation: MainScreen.routeName,
    // observers: [NavigatorObserverService()],
    routes: [
      GoRoute(
        name: mainScreen,
        path: MainScreen.routeName,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProjectsBloc(locator())),
            BlocProvider(create: (context) => CalendarBloc(locator())),
          ],
          child: const MainScreen(),
        ),
      ),
      GoRoute(
        name: projectDetailsScreen,
        path: ProjectDetailsScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => DetailsBloc(locator()),
          child: const ProjectDetailsScreen(),
        ),
      ),
      GoRoute(
        name: dateDetailsScreen,
        path: DateDetailsScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => DateDetailsBloc(locator()),
          child: const DateDetailsScreen(),
        ),
      ),
    ],
    // errorBuilder: (context, state) => const PageNotFoundScreen(),
  );
}
