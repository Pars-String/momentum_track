import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:momentum_track/core/constant/app_arguments.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/resources/app_routes.dart';
import 'package:momentum_track/core/utils/extensions/context_extension.dart';
import 'package:momentum_track/core/utils/extensions/date_formatter_extension.dart';
import 'package:momentum_track/core/utils/extensions/duration_extension.dart';
import 'package:momentum_track/core/widgets/app_elevated_button.dart';
import 'package:momentum_track/core/widgets/app_modal_bottom_sheet.dart';
import 'package:momentum_track/features/projects/presentation/blocs/projects_bloc/projects_bloc.dart';
import 'package:momentum_track/features/projects/presentation/widgets/add_project_dialog_box.dart';
import 'package:momentum_track/features/projects/presentation/widgets/project_info_dialog_box.dart';

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.project.name),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Total duration: ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: context.colorScheme.primary
                                        .withAlpha(150),
                                  ),
                                ),
                                if (widget.isCalculating)
                                  TextSpan(
                                    text: 'calculating...',
                                    style: TextStyle(
                                      color: context.colorScheme.primary
                                          .withAlpha(200),
                                    ),
                                  )
                                else if (widget.hasError)
                                  TextSpan(
                                    text: 'Error calculating duration',
                                    style: TextStyle(
                                      color: context.colorScheme.error,
                                    ),
                                  )
                                else
                                  TextSpan(
                                    text: widget.duration.inHourAndMinutes,
                                  ),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Start from: ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: context.colorScheme.primary
                                        .withAlpha(150),
                                  ),
                                ),
                                if (widget.project.startDate == null)
                                  TextSpan(
                                    text: '-',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: context.colorScheme.primary
                                          .withAlpha(150),
                                    ),
                                  )
                                else
                                  TextSpan(
                                    text: widget
                                        .project
                                        .startDate
                                        .yearMonthDayShort,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Gap(16),
                  ],
                ),
                Gap(5),

                Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                  child: Text(
                    widget.project.description ?? '-',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: TextStyle(
                      color: context.colorScheme.onSurface.withAlpha(150),
                      fontSize: 12,
                    ),
                  ),
                ),
                Gap(8),
              ],
            ),
          ),
          if (showButtons)
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withAlpha(100),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Gap(4),
                      IconButton(
                        onPressed: () {
                          context.pushNamed(
                            AppRoutes.projectDetailsScreen,
                            pathParameters: {
                              AppArguments.projectID: widget.project.id
                                  .toString(),
                            },
                          );
                        },
                        icon: HugeIcon(
                          icon: HugeIcons.strokeRoundedCalendar02,
                          color: context.colorScheme.primary,
                        ),
                      ),
                      Gap(8),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return ProjectInfoDialogBox(
                                projectInfo: widget.project,
                                thisMonthDuration:
                                    widget.duration ?? Duration.zero,
                              );
                            },
                          );
                        },
                        icon: HugeIcon(
                          icon: HugeIcons.strokeRoundedFolderDetails,
                          color: context.colorScheme.primary,
                        ),
                      ),
                      Gap(8),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return AddProjectDialogBox(
                                innerContext: context,
                                projectInfo: widget.project,
                              );
                            },
                          );
                        },
                        icon: HugeIcon(
                          icon: HugeIcons.strokeRoundedEdit01,
                          color: context.colorScheme.primary,
                        ),
                      ),
                      Gap(8),
                      IconButton(
                        onPressed: () {
                          AppModalBottomSheet.show(
                            context,
                            title: 'Delete Project',
                            children: [
                              Text(
                                'Do you really want to delete ${widget.project.name} project? This action cannot be undone and delete all time entries related with this project.',
                              ),
                              Gap(16),
                              Row(
                                children: [
                                  Expanded(
                                    child: AppElevatedButton(
                                      onPressed: () {
                                        context
                                          ..read<ProjectsBloc>().add(
                                            DeleteProject(widget.project.id),
                                          )
                                          ..pop();
                                      },
                                      title: 'Delete',
                                    ),
                                  ),
                                  Gap(8),
                                  TextButton(
                                    onPressed: () => context.pop(),
                                    child: Text('Cancel'),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                        icon: HugeIcon(
                          icon: HugeIcons.strokeRoundedDelete03,
                          color: context.colorScheme.primary,
                        ),
                      ),
                      Gap(4),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
