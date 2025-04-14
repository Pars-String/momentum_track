import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hugeicons/hugeicons.dart';

class AppElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final String title;
  final IconData? icon;
  const AppElevatedButton({
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    required this.title,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            backgroundColor ?? Theme.of(context).colorScheme.primary,
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            HugeIcon(
              icon: icon!,
              color: textColor ?? Theme.of(context).colorScheme.onPrimary,
            ),
            Gap(8),
          ],
          Text(
            title,
            style: TextStyle(
              color: textColor ?? Theme.of(context).colorScheme.onPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
