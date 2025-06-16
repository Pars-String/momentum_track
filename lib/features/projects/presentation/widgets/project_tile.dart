import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/resources/app_routes.dart';
import 'package:momentum_track/core/utils/extensions/context_extension.dart';
import 'package:momentum_track/core/utils/extensions/date_formatter_extension.dart';
import 'package:momentum_track/core/utils/extensions/duration_extension.dart';
import 'package:momentum_track/core/utils/helpers/calculating_helper.dart';
import 'package:momentum_track/core/widgets/app_elevated_button.dart';
import 'package:momentum_track/core/widgets/app_modal_bottom_sheet.dart';
import 'package:momentum_track/features/projects/presentation/bloc/projects_bloc.dart';
import 'package:momentum_track/features/projects/presentation/widgets/add_project_dialog_box.dart';

class ProjectTile extends StatelessWidget {
  final Project project;
  final List<TimeEntry> timeEntries;
  const ProjectTile({
    required this.project,
    required this.timeEntries,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Duration>(
      future: CalculatingHelper.calculateDurationFrom(timeEntries, project.id),
      builder: (context, asyncSnapshot) {
        final bool isLoadingToCalculate =
            asyncSnapshot.connectionState == ConnectionState.waiting;
        final bool isCalculatingHasError = asyncSnapshot.hasError;

        return InkWell(
          onTap: () {
            context.pushNamed(AppRoutes.projectDetailsScreen, extra: project);
          },
          child: DecoratedBox(
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
                          Text(project.name),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'This Month: ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: context.colorScheme.primary
                                        .withAlpha(150),
                                  ),
                                ),
                                if (isLoadingToCalculate)
                                  TextSpan(
                                    text: 'calculating...',
                                    style: TextStyle(
                                      color: context.colorScheme.primary
                                          .withAlpha(200),
                                    ),
                                  )
                                else if (isCalculatingHasError)
                                  TextSpan(
                                    text: 'Error calculating duration',
                                    style: TextStyle(
                                      color: context.colorScheme.error,
                                    ),
                                  )
                                else
                                  TextSpan(
                                    text: asyncSnapshot.data.inHourAndMinutes,
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
                                if (project.startDate == null)
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
                                    text: project.startDate.yearMonthDayShort,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton(
                      borderRadius: BorderRadius.circular(8),
                      color: context.colorScheme.primary,
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedEdit01,
                        color: context.colorScheme.primary,
                        size: 20,
                      ),
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: Text(
                              'Edit',
                              style: TextStyle(
                                color: context.colorScheme.onPrimary,
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return AddProjectDialogBox(
                                    innerContext: context,
                                    projectInfo: project,
                                  );
                                },
                              );
                            },
                          ),
                          PopupMenuItem(
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                color: context.colorScheme.onPrimary,
                              ),
                            ),
                            onTap: () {
                              AppModalBottomSheet.show(
                                context,
                                title: 'Delete Project',
                                children: [
                                  Text(
                                    'Do you really want to delete ${project.name} project? This action cannot be undone and delete all time entries related with this project.',
                                  ),
                                  Gap(16),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: AppElevatedButton(
                                          onPressed: () {
                                            context
                                              ..read<ProjectsBloc>().add(
                                                DeleteProject(project.id),
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
                          ),
                        ];
                      },
                    ),
                    Gap(8),
                  ],
                ),
                Gap(5),

                Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                  child: Text(
                    project.description ?? '-',
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
        );
      },
    );
  }
}
