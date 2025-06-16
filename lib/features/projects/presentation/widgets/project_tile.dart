import 'package:flutter/material.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/utils/helpers/calculating_helper.dart';
import 'package:momentum_track/features/projects/presentation/widgets/tile_info.dart';

class ProjectTile extends StatefulWidget {
  final Project project;
  final List<TimeEntry> timeEntries;
  const ProjectTile({
    required this.project,
    required this.timeEntries,
    super.key,
  });

  @override
  State<ProjectTile> createState() => _ProjectTileState();
}

class _ProjectTileState extends State<ProjectTile> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Duration>(
      future: CalculatingHelper.calculateDurationFrom(
        widget.timeEntries,
        widget.project.id,
      ),
      builder: (context, asyncSnapshot) {
        return TileInfo(
          project: widget.project,
          duration: asyncSnapshot.data ?? Duration.zero,
          isCalculating:
              asyncSnapshot.connectionState == ConnectionState.waiting,
          hasError: asyncSnapshot.hasError,
        );
      },
    );
  }
}
