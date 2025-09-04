import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/widgets/add_new_event_button.dart';
import 'package:momentum_track/core/widgets/app_time_entry_form_with_dialog_box.dart';
import 'package:momentum_track/features/project_details/presentation/bloc/project_details_bloc.dart';

class ProjectDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ProjectDetailsAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectDetailsBloc, ProjectDetailsState>(
      builder: (context, state) {
        late Project project;
        final isFetched = state.projectDetailsStatus is ProjectDetailsSuccess;
        String projectName = 'Fetching Data...';

        if (isFetched) {
          project =
              (state.projectDetailsStatus as ProjectDetailsSuccess).projectInfo;
          projectName = project.name;
        }

        return AppBar(
          title: Text(projectName),
          actions: [
            BlocBuilder<ProjectDetailsBloc, ProjectDetailsState>(
              builder: (context, state) {
                return AddNewEventButton(
                  onPressed: !isFetched
                      ? null
                      : () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return AppTimeEntryFormWithDialogBox(
                                projects: null,
                                selectedDate: DateTime.now(),
                                timeEntry: null,
                                onPressedDelete: null,
                                onPressedSubmit: (timeEntry) {
                                  context.read<ProjectDetailsBloc>().add(
                                    AddNewTimeEntry(
                                      timeEntry: timeEntry.copyWith(
                                        projectID: project.id,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                );
              },
            ),
          ],
          // bottom: PreferredSize(
          //   preferredSize: Size(MediaQuery.sizeOf(context).width, 100),
          //   child: SelectingMonth(project.id),
          // ),
        );
      },
    );
  }
}
