import 'package:flutter/material.dart';
import 'package:momentum_track/core/l10n/generated/l10n.dart';
import 'package:momentum_track/features/projects/presentation/widgets/add_project_dialog_box.dart';

class AddNewProjectButton extends StatelessWidget {
  const AddNewProjectButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: S.current.tooltip_addProject,
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) {
            return AddProjectDialogBox(
              innerContext: context,
              projectInfo: null,
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
