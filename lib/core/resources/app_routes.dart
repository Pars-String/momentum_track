import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:momentum_track/features/projects/presentation/bloc/projects_bloc.dart';
import 'package:momentum_track/features/projects/presentation/screens/projects_screen.dart';
import 'package:momentum_track/locator.dart';

class AppRoutes {
  static const String projectsScreen = 'projectsScreen';

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
    ],
    // errorBuilder: (context, state) => const PageNotFoundScreen(),
  );
}
