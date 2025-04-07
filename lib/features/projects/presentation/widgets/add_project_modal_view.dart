import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:momentum_track/core/widgets/app_elevated_button.dart';
import 'package:momentum_track/core/widgets/app_text_form_field.dart';
import 'package:momentum_track/features/projects/presentation/bloc/projects_bloc.dart';

class AddProjectModalView extends StatefulWidget {
  final BuildContext innerContext;
  const AddProjectModalView({required this.innerContext, super.key});

  @override
  State<AddProjectModalView> createState() => _AddProjectModalViewState();
}

class _AddProjectModalViewState extends State<AddProjectModalView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _startDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.innerContext.read<ProjectsBloc>(),
      child: Builder(
        builder: (context) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                AppTextFormField(
                  // label: 'Project Name',
                  hint: 'Enter project name',
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  validatorText: 'Please enter a project name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a project name';
                    }
                    return null;
                  },
                ),
                Gap(25),
                Row(
                  children: [
                    Expanded(
                      child: AppElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            context.read<ProjectsBloc>().add(
                              AddNewProject(_nameController.text),
                            );
                            context.pop();
                          }
                        },
                        title: 'Save',
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
                Gap(35),
              ],
            ),
          );
        },
      ),
    );
  }
}
