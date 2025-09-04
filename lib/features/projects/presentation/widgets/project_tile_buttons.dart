import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:momentum_track/core/constant/app_arguments.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/resources/app_routes.dart';
import 'package:momentum_track/core/utils/extensions/context_extension.dart';
import 'package:momentum_track/features/projects/presentation/widgets/add_project_dialog_box.dart';
import 'package:momentum_track/features/projects/presentation/widgets/delete_project_dialog_box.dart';
import 'package:momentum_track/features/projects/presentation/widgets/project_info_dialog_box.dart';

class ProjectTileButtons extends StatelessWidget {
  final Project project;
  final BuildContext innerContext;
  const ProjectTileButtons({
    required this.project,
    required this.innerContext,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
              color: Theme.of(context).colorScheme.primary.withAlpha(100),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Gap(4),
              IconButton(
                onPressed: () {
                  context.pushNamed(
                    AppRoutes.projectDetailsScreen,
                    pathParameters: {
                      AppArguments.projectID: project.id.toString(),
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
                      return ProjectInfoDialogBox(projectInfo: project);
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
                        projectInfo: project,
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
                  showDialog(
                    context: context,
                    builder: (_) {
                      return DeleteProjectDialogBox(
                        innerContext: innerContext,
                        project: project,
                      );
                    },
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
    );
  }
}
