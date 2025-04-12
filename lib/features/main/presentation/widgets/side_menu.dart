import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:momentum_track/core/constant/app_pages.dart';
import 'package:momentum_track/core/constant/app_versions.dart';
import 'package:momentum_track/features/main/presentation/cubit/menu_cubit.dart';
import 'package:momentum_track/features/main/presentation/widgets/menu_item.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  bool isExpanded = false;
  bool isCompletedOpen = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isExpanded ? 145 : 65,
      color: Theme.of(context).colorScheme.primaryContainer,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      onEnd: () {
        if (isExpanded) {
          isCompletedOpen = true;
          setState(() {});
        }
      },

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: HugeIcon(
              icon:
                  isExpanded
                      ? HugeIcons.strokeRoundedSidebarLeft01
                      : HugeIcons.strokeRoundedSidebarLeft,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            onPressed: () {
              isExpanded = !isExpanded;
              if (!isExpanded) isCompletedOpen = false;

              setState(() {});
            },
          ),
          Gap(35),
          MenuItem(
            title: 'Projects',
            icon: HugeIcons.strokeRoundedLeftToRightListNumber,
            showTitle: isCompletedOpen,
            page: AppPages.projects,
            onTap: () {
              context.read<MenuCubit>().changePage(AppPages.projects);
            },
          ),

          Gap(14),
          MenuItem(
            title: 'Archives',
            icon: HugeIcons.strokeRoundedArchive02,
            showTitle: isCompletedOpen,
            page: AppPages.archives,
            onTap: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Coming soon...')));
            },
          ),

          Gap(14),
          MenuItem(
            title: 'Settings',
            icon: HugeIcons.strokeRoundedDashboardCircleSettings,
            showTitle: isCompletedOpen,
            page: AppPages.settings,
            onTap: () {
              context.read<MenuCubit>().changePage(AppPages.settings);
            },
          ),

          Spacer(),
          Text(
            'DEV ${AppVersions.appVersion}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.surface,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}
