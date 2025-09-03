import 'package:flutter/material.dart';
import 'package:momentum_track/features/projects/presentation/widgets/add_project_dialog_box.dart';

class AddNewProjectButton extends StatelessWidget {
  const AddNewProjectButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'Add Project',
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
