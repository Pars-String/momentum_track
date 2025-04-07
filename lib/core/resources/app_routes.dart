import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:momentum_track/features/project_details/presentation/bloc/details_bloc.dart';
import 'package:momentum_track/features/project_details/presentation/screens/project_details_screen.dart';
import 'package:momentum_track/features/projects/presentation/bloc/projects_bloc.dart';
import 'package:momentum_track/features/projects/presentation/screens/projects_screen.dart';
import 'package:momentum_track/locator.dart';

class AppRoutes {
  static const String projectsScreen = 'projectsScreen';
  static const String projectDetailsScreen = 'projectDetailsScreen';

  static GoRouter router = GoRouter(
    // navigatorKey: navigatorKey,
    debugLogDiagnostics: kDebugMode,
    initialLocation: ProjectsScreen.routeName,
    // observers: [NavigatorObserverService()],
    routes: [
      GoRoute(
        name: projectsScreen,
        path: ProjectsScreen.routeName,
        builder:
            (context, state) => BlocProvider(
              create: (context) => ProjectsBloc(locator()),
              child: const ProjectsScreen(),
            ),
      ),
      GoRoute(
        name: projectDetailsScreen,
        path: ProjectDetailsScreen.routeName,
        builder:
            (context, state) => BlocProvider(
              create: (context) => DetailsBloc(locator()),
              child: const ProjectDetailsScreen(),
            ),
      ),
    ],
    // errorBuilder: (context, state) => const PageNotFoundScreen(),
  );
}
