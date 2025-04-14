import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum_track/core/constant/app_pages.dart';
import 'package:momentum_track/features/main/presentation/cubit/menu_cubit.dart';
import 'package:momentum_track/features/main/presentation/widgets/side_menu.dart';
import 'package:momentum_track/features/month_overview/presentation/screens/month_overview.dart';
import 'package:momentum_track/features/projects/presentation/screens/projects_screen.dart';
import 'package:momentum_track/features/settings/presentation/screens/settings_screen.dart';

class MainScreen extends StatelessWidget {
  static const String routeName = '/';
  const MainScreen({super.key});

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
