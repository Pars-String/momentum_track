import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:momentum_track/core/constant/app_pages.dart';
import 'package:momentum_track/features/main/presentation/cubit/menu_cubit.dart';

class MenuItem extends StatefulWidget {
  final bool showTitle;
  final IconData icon;
  final String title;
  final AppPages page;
  final VoidCallback? onTap;
  const MenuItem({
    required this.title,
    required this.icon,
    required this.showTitle,
    required this.page,
    required this.onTap,
    super.key,
  });

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(
      builder: (context, state) {
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color:
                isHovered || widget.page == state.selectedPage
                    ? Colors.white30
                    : Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: InkWell(
              onTap: widget.page == state.selectedPage ? null : widget.onTap,
              onHover: (value) {
                isHovered = !isHovered;
                setState(() {});
              },
              child: Row(
                children: [
                  Gap(8),
                  HugeIcon(
                    icon: widget.icon,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  if (widget.showTitle) ...[
                    Gap(8),
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
