import 'package:flutter/material.dart';
import 'package:momentum_track/core/resources/app_routes.dart';
import 'package:momentum_track/core/theme/app_theme.dart';
import 'package:momentum_track/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await locatorSetup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRoutes.router,
      title: 'Momentum Track',
      theme: appTheme,
      darkTheme: darkTheme,
    );
  }
}
