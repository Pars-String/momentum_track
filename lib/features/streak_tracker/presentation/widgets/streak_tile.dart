import 'package:flutter/material.dart';
import 'package:momentum_track/main.dart';

class StreakTile extends StatelessWidget {
  final int repeat;
  final bool isBlank;
  final String? day;
  const StreakTile({
    this.repeat = 0,
    this.isBlank = false,
    this.day,
    super.key,
  });

  int get alpha {
    if (repeat > 0 && repeat <= 15) return 100 + (repeat * 10);

    return 255;
  }

  Color? get tileColor {
    final BuildContext context = navigatorKey.currentState!.context;

    if (isBlank) return null;
    return repeat > 0
        ? Theme.of(context).colorScheme.primaryContainer.withAlpha(alpha)
        : Theme.of(context).scaffoldBackgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: tileColor,
        ),
        child: SizedBox.square(
          dimension: 20,
          child: day == null
              ? null
              : Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: FittedBox(
                    child: Text(
                      day!,
                      style: TextStyle(
                        color: repeat > 0
                            ? Theme.of(context).scaffoldBackgroundColor
                            : Theme.of(context).colorScheme.primaryContainer,
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
