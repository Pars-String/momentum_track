import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum_track/core/constant/app_pages.dart';
import 'package:momentum_track/features/main/presentation/cubit/menu_cubit.dart';
import 'package:momentum_track/features/main/presentation/widgets/side_menu.dart';
import 'package:momentum_track/features/month_overview/presentation/screens/month_overview.dart';
import 'package:momentum_track/features/projects/presentation/screens/projects_screen.dart';
import 'package:momentum_track/features/settings/presentation/screens/settings_screen.dart';
import 'package:window_manager/window_manager.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = '/';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WindowListener {
  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (!mounted || !isPreventClose) return;
    windowManager.destroy();
  }

  @override
  void initState() {
    windowManager.addListener(this);
    windowManager.setPreventClose(true);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideMenu(),
          Expanded(
            child: BlocBuilder<MenuCubit, MenuState>(
              builder: (context, state) {
                if (state.selectedPage == AppPages.projects) {
                  return ProjectsScreen();
                }
                if (state.selectedPage == AppPages.settings) {
                  return SettingsScreen();
                }
                if (state.selectedPage == AppPages.overview) {
                  return MonthOverviewScreen();
                }
                return SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
