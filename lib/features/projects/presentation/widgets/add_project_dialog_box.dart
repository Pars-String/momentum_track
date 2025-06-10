import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/utils/extensions/date_formatter_extension.dart';
import 'package:momentum_track/core/widgets/app_elevated_button.dart';
import 'package:momentum_track/core/widgets/app_text_form_field.dart';
import 'package:momentum_track/features/projects/presentation/bloc/projects_bloc.dart';

class AddProjectDialogBox extends StatefulWidget {
  final BuildContext innerContext;
  final Project? projectInfo;
  const AddProjectDialogBox({
    required this.innerContext,
    required this.projectInfo,
    super.key,
  });

  @override
  State<AddProjectDialogBox> createState() => _AddProjectDialogBoxState();
}

class _AddProjectDialogBoxState extends State<AddProjectDialogBox> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  DateTime? pickedStartDate;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _startDateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.projectInfo != null) {
      _nameController.text = widget.projectInfo!.name;
      _descriptionController.text = widget.projectInfo!.description ?? '';
      pickedStartDate = widget.projectInfo!.startDate;
      if (pickedStartDate != null) {
        _startDateController.text = pickedStartDate.monthWeekdayDay!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.innerContext.read<ProjectsBloc>(),
      child: Builder(
        builder: (context) {
          return BlocBuilder<ProjectsBloc, ProjectsState>(
            builder: (context, state) {
              return SimpleDialog(
                title: Text(
                  widget.projectInfo == null
                      ? 'Add New Project'
                      : 'Edit Project',
                ),
                contentPadding: const EdgeInsets.all(16),

                children: [
                  Form(
                    key: _formKey,
                    child: SizedBox(
                      width: 530,
                      child: Column(
                        children: [
                          AppTextFormField(
                            label: 'Project Name',
                            controller: _nameController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a project name';
                              }
                              return null;
                            },
                          ),

                          Gap(8),
                          AppTextFormField(
                            label: 'Start at',
                            controller: _startDateController,
                            readOnly: true,
                            onTap: (focusNode) {
                              showDatePicker(
                                context: context,
                                initialDate: pickedStartDate,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              ).then((pickedDate) async {
                                if (pickedDate != null) {
                                  pickedStartDate = pickedDate.copyWith(
                                    hour: 0,
                                    minute: 0,
                                    second: 0,
                                    millisecond: 0,
                                    microsecond: 0,
                                  );
                                  _startDateController.text =
                                      pickedDate.monthWeekdayDay!;
                                }
                              });
                            },
                          ),
                          Gap(16),
                          AppTextFormField(
                            controller: _descriptionController,
                            hint: 'Enter description (optional)',
                            minLines: 3,
                          ),
                          Gap(16),

                          Row(
                            children: [
                              Expanded(
                                child: AppElevatedButton(
                                  onPressed: () {
                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    }
                                    if (widget.projectInfo == null) {
                                      context
                                        ..read<ProjectsBloc>().add(
                                          AddNewProject(
                                            projectName: _nameController.text,
                                            description:
                                                _descriptionController.text,
                                            startDate: pickedStartDate,
                                          ),
                                        )
                                        ..pop();
                                      return;
                                    }
                                    context
                                      ..read<ProjectsBloc>().add(
                                        EditProject(
                                          projectInfo: widget.projectInfo!
                                              .copyWith(
                                                name: _nameController.text,
                                                description: Value(
                                                  _descriptionController.text,
                                                ),
                                                startDate: Value(
                                                  pickedStartDate,
                                                ),
                                              ),
                                        ),
                                      )
                                      ..pop();
                                  },
                                  title: 'Submit',
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
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
