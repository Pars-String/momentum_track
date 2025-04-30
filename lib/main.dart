import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum_track/core/bloc/global_date_cubit/global_date_cubit.dart';
import 'package:momentum_track/core/resources/app_routes.dart';
import 'package:momentum_track/core/theme/app_theme.dart';
import 'package:momentum_track/features/main/presentation/cubit/menu_cubit.dart';
import 'package:momentum_track/locator.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await locatorSetup();

  WindowOptions windowOptions = WindowOptions(
    minimumSize: const Size(850, 600),
    // maximumSize: const Size(800, 600),
    size: Size(850, 600),
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GlobalDateCubit()..setThisMonthDates(),
        ),
        BlocProvider(create: (context) => MenuCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRoutes.router,
      title: 'Momentum Track',
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
    );
  }
}
