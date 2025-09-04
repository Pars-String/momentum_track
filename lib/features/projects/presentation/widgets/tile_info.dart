import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/utils/extensions/context_extension.dart';
import 'package:momentum_track/features/projects/presentation/widgets/project_tile_buttons.dart';
import 'package:momentum_track/features/projects/presentation/widgets/start_from.dart';
import 'package:momentum_track/features/projects/presentation/widgets/total_duration.dart';

class TileInfo extends StatefulWidget {
  final Project project;
  final bool isCalculating;
  final bool hasError;
  final Duration? duration;
  const TileInfo({
    required this.project,
    required this.isCalculating,
    required this.hasError,
    required this.duration,
    super.key,
  });

  @override
  State<TileInfo> createState() => _TileInfoState();
}

class _TileInfoState extends State<TileInfo> {
  bool showButtons = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      onHover: (value) {
        setState(() {
          showButtons = value;
        });
      },
      child: Stack(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary.withAlpha(100),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.project.name),
                        TotalDuration(
                          isCalculating: widget.isCalculating,
                          hasError: widget.hasError,
                          duration: widget.duration,
                        ),
                        StartFrom(project: widget.project),
                      ],
                    ),
                  ),
                  Gap(5),
                  Text(
                    widget.project.description ?? '-',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: TextStyle(
                      color: context.colorScheme.onSurface.withAlpha(150),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (showButtons)
            ProjectTileButtons(project: widget.project, innerContext: context),
        ],
      ),
    );
  }
}
