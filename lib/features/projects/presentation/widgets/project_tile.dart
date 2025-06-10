import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/resources/app_routes.dart';
import 'package:momentum_track/core/utils/extensions/context_extension.dart';
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

        return ListTile(
          title: Text(project.name),

          trailing: PopupMenuButton(
            borderRadius: BorderRadius.circular(8),
            color: context.colorScheme.primary,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text(
                    'Edit',
                    style: TextStyle(color: context.colorScheme.onPrimary),
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
                    style: TextStyle(color: context.colorScheme.onPrimary),
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
          subtitle: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'This Month: '),
                if (isLoadingToCalculate)
                  TextSpan(
                    text: 'Calculating...\n',
                    style: TextStyle(
                      color: context.colorScheme.primary.withAlpha(150),
                    ),
                  )
                else if (isCalculatingHasError)
                  TextSpan(
                    text: 'Error calculating duration\n',
                    style: TextStyle(color: context.colorScheme.error),
                  )
                else
                  TextSpan(
                    text:
                        '${asyncSnapshot.data?.inHours}h ${asyncSnapshot.data?.inMinutes.remainder(60)}m\n',
                  ),

                if (project.description == null ||
                    (project.description?.isEmpty ?? false))
                  TextSpan(text: '-'),
                if (project.description?.isNotEmpty ?? false)
                  TextSpan(text: project.description),
              ],
            ),
          ),
          onTap: () {
            context.pushNamed(AppRoutes.projectDetailsScreen, extra: project);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Theme.of(context).colorScheme.primary.withAlpha(100),
            ),
          ),
        );
      },
    );
  }
}
