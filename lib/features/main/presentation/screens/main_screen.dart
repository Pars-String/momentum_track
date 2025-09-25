import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum_track/core/bloc/global_data_flow/global_data_flow_cubit.dart';
import 'package:momentum_track/core/bloc/global_date_cubit/global_date_cubit.dart';
import 'package:momentum_track/core/constant/app_pages.dart';
import 'package:momentum_track/core/utils/helpers/date_helper.dart';
import 'package:momentum_track/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:momentum_track/features/main/presentation/cubit/menu_cubit.dart';
import 'package:momentum_track/features/main/presentation/widgets/side_menu.dart';
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
  late DateTime today;

  int? get _selectedIndex {
    final state = context.read<MenuCubit>().state.selectedPage;
    if (state == AppPages.overview) return 0;
    if (state == AppPages.projects) return 1;
    if (state == AppPages.settings) return 2;
    return null;
  }

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

    context.read<GlobalDateCubit>().setThisMonthDates();
    today = context.read<GlobalDateCubit>().state.today;

    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GlobalDateCubit, GlobalDateState>(
      listenWhen: (p, c) => p.today != c.today,
      listener: (context, state) {
        if (!DateHelper.isToday(today, state.today)) {
          today = state.today;
          context.read<GlobalDataFlowCubit>()
            ..resetHeatMapStatus()
            ..resetProjectOverviewStatus();
        }
      },
      child: Scaffold(
        body: Row(
          children: [
            SideMenu(),
            Expanded(
              child: BlocBuilder<MenuCubit, MenuState>(
                builder: (context, state) {
                  return IndexedStack(
                    index: _selectedIndex,
                    children: [
                      CalendarScreen(),
                      ProjectsScreen(),
                      SettingsScreen(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
