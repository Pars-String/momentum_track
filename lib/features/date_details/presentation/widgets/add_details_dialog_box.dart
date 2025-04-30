import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/widgets/app_elevated_button.dart';
import 'package:momentum_track/core/widgets/app_text_form_field.dart';
import 'package:momentum_track/features/date_details/presentation/bloc/date_details_bloc.dart';

class AddDetailsDialogBox extends StatefulWidget {
  final BuildContext innerContext;
  final TimeEntry? timeEntry;
  final DateTime selectedDate;
  const AddDetailsDialogBox({
    required this.innerContext,
    required this.selectedDate,
    this.timeEntry,
    super.key,
  });

  @override
  State<AddDetailsDialogBox> createState() => _AddDetailsDialogBoxState();
}

class _AddDetailsDialogBoxState extends State<AddDetailsDialogBox> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final startTimeFormKey = GlobalKey<FormState>();
  final allFormKey = GlobalKey<FormState>();
  int? projectID;

  DateTime? pickedStartDate;
  DateTime? pickedEndDate;

  DateTime? selectedStartDateTime;
  DateTime? selectedEndDateTime;

  bool hasInitialized = false;

  void initStartDate(DateTime selectedDateState, {bool? isEditing}) {
    hasInitialized = true;
    startDateController.text = DateFormat.MMMMEEEEd().format(selectedDateState);
    pickedStartDate = selectedDateState.copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );

    if (isEditing == true) {
      selectedStartDateTime = selectedDateState;
      startTimeController.text = DateFormat('h:mm a').format(selectedDateState);
    }
  }

  void initEndDate(DateTime selectedDateState) {
    endDateController.text = DateFormat.MMMMEEEEd().format(selectedDateState);
    pickedEndDate = selectedDateState.copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );

    selectedEndDateTime = selectedDateState;
    endTimeController.text = DateFormat('h:mm a').format(selectedDateState);
  }

  @override
  void dispose() {
    descriptionController.dispose();
    startDateController.dispose();
    startTimeController.dispose();
    endDateController.dispose();
    endTimeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.timeEntry != null) {
      projectID = widget.timeEntry!.projectId;
      descriptionController.text = widget.timeEntry!.note ?? '';
      initStartDate(widget.timeEntry!.startTime, isEditing: true);
      if (widget.timeEntry!.endTime != null) {
        initEndDate(widget.timeEntry!.endTime!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.innerContext.read<DateDetailsBloc>(),
      child: Builder(
        builder: (context) {
          return BlocBuilder<DateDetailsBloc, DateDetailsState>(
            builder: (context, state) {
              final List<Project> projects = state.projects;
              if (widget.timeEntry == null && !hasInitialized) {
                initStartDate(widget.selectedDate);
              }

              return SimpleDialog(
                title: const Text('Add Time Entry'),
                contentPadding: const EdgeInsets.all(16),

                children: [
                  SizedBox(
                    width: 530,
                    child: Column(
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          child: DropdownButton<int>(
                            hint: const Text('Choose your Project'),
                            borderRadius: BorderRadius.circular(16),
                            isExpanded: true,
                            elevation: 1,
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            underline: SizedBox.shrink(),
                            value: projectID,
                            items:
                                projects.map((e) {
                                  return DropdownMenuItem<int>(
                                    value: e.id,
                                    child: Text(e.name),
                                  );
                                }).toList(),
                            onChanged: (value) {
                              projectID = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Gap(16),
                        Form(
                          key: allFormKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 95,
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      child: AppTextFormField(
                                        label: 'Start at',
                                        controller: startDateController,
                                        readOnly: true,
                                        onTap: (focusNode) {
                                          showDatePicker(
                                            context: context,
                                            initialDate:
                                                selectedStartDateTime ??
                                                widget.selectedDate,
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2100),
                                          ).then((pickedDate) async {
                                            if (pickedDate != null) {
                                              pickedStartDate = pickedDate
                                                  .copyWith(
                                                    hour: 0,
                                                    minute: 0,
                                                    second: 0,
                                                    millisecond: 0,
                                                    microsecond: 0,
                                                  );
                                              startDateController
                                                  .text = DateFormat.MMMMEEEEd()
                                                  .format(pickedDate);
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    Gap(8),
                                    Flexible(
                                      child: Form(
                                        key: startTimeFormKey,
                                        child: AppTextFormField(
                                          controller: startTimeController,
                                          label: 'time',
                                          readOnly: true,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return '*Required';
                                            }
                                            return null;
                                          },
                                          onTap: (focusNode) {
                                            showTimePicker(
                                              context: context,
                                              initialTime:
                                                  selectedStartDateTime != null
                                                      ? TimeOfDay.fromDateTime(
                                                        selectedStartDateTime!,
                                                      )
                                                      : TimeOfDay.now(),
                                              initialEntryMode:
                                                  TimePickerEntryMode.inputOnly,
                                            ).then((pickedTime) async {
                                              if (pickedTime != null) {
                                                selectedStartDateTime =
                                                    pickedStartDate!.add(
                                                      Duration(
                                                        hours: pickedTime.hour,
                                                        minutes:
                                                            pickedTime.minute,
                                                      ),
                                                    );
                                                startTimeController.text =
                                                    DateFormat('h:mm a').format(
                                                      selectedStartDateTime!,
                                                    );
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: AppTextFormField(
                                      label: 'End at (optional)',
                                      controller: endDateController,
                                      readOnly: true,
                                      onTap: (focusNode) {
                                        showDatePicker(
                                          context: context,
                                          initialDate: selectedEndDateTime,
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2100),
                                        ).then((pickedDate) async {
                                          if (pickedDate != null) {
                                            pickedEndDate = pickedDate.copyWith(
                                              hour: 0,
                                              minute: 0,
                                              second: 0,
                                              millisecond: 0,
                                              microsecond: 0,
                                            );
                                            endDateController
                                                .text = DateFormat.MMMMEEEEd()
                                                .format(pickedDate);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Gap(8),
                                  Flexible(
                                    child: AppTextFormField(
                                      controller: endTimeController,
                                      label: 'time',
                                      readOnly: true,
                                      onTap: (focusNode) {
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.fromDateTime(
                                            selectedEndDateTime ??
                                                DateTime.now(),
                                          ),
                                          initialEntryMode:
                                              TimePickerEntryMode.inputOnly,
                                        ).then((pickedTime) async {
                                          if (pickedTime != null) {
                                            selectedEndDateTime = pickedEndDate!
                                                .add(
                                                  Duration(
                                                    hours: pickedTime.hour,
                                                    minutes: pickedTime.minute,
                                                  ),
                                                );
                                            endTimeController.text = DateFormat(
                                              'h:mm a',
                                            ).format(selectedEndDateTime!);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),

                              Gap(16),
                              AppTextFormField(
                                controller: descriptionController,
                                hint: 'Enter description (optional)',
                                minLines: 3,
                              ),
                              Gap(16),
                            ],
                          ),
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: AppElevatedButton(
                                onPressed:
                                    projectID == null
                                        ? null
                                        : () {
                                          if (widget.timeEntry != null) {
                                            if (startTimeFormKey.currentState!
                                                .validate()) {
                                              context
                                                  .read<DateDetailsBloc>()
                                                  .add(
                                                    EditTimeEntry(
                                                      id: widget.timeEntry!.id,
                                                      projectID: projectID!,
                                                      note:
                                                          descriptionController
                                                              .text,
                                                      startTime:
                                                          selectedStartDateTime!,
                                                      endTime:
                                                          selectedEndDateTime,
                                                    ),
                                                  );
                                              context.pop();
                                            }
                                          } else {
                                            if (startTimeFormKey.currentState!
                                                .validate()) {
                                              context
                                                  .read<DateDetailsBloc>()
                                                  .add(
                                                    AddNewTimeEntry(
                                                      projectID: projectID!,
                                                      note:
                                                          descriptionController
                                                              .text,
                                                      startTime:
                                                          selectedStartDateTime!,
                                                      endTime:
                                                          selectedEndDateTime,
                                                    ),
                                                  );
                                              context.pop();
                                            }
                                          }
                                        },
                                title: 'Add',
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
                ],
              );
            },
          );
        },
      ),
    );
  }
}
