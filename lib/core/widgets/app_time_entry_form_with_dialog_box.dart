import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:momentum_track/core/data/models/time_entry_form.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/utils/extensions/date_formatter_extension.dart';
import 'package:momentum_track/core/utils/extensions/date_reset_extension.dart';
import 'package:momentum_track/core/widgets/app_elevated_button.dart';
import 'package:momentum_track/core/widgets/app_text_form_field.dart';
import 'package:momentum_track/core/widgets/delete_event_button.dart';

class AppTimeEntryFormWithDialogBox extends StatefulWidget {
  final TimeEntry? timeEntry;
  final DateTime selectedDate;
  final Function(TimeEntryForm timeEntry) onPressedSubmit;
  final VoidCallback? onPressedDelete;
  final List<Project>? projects;
  const AppTimeEntryFormWithDialogBox({
    required this.selectedDate,
    required this.onPressedSubmit,
    required this.onPressedDelete,
    this.projects,
    this.timeEntry,
    super.key,
  });

  @override
  State<AppTimeEntryFormWithDialogBox> createState() =>
      _AppTimeEntryFormWithDialogBoxState();
}

class _AppTimeEntryFormWithDialogBoxState
    extends State<AppTimeEntryFormWithDialogBox> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  int? projectID;

  DateTime? pickedStartDate;
  DateTime? pickedEndDate;

  DateTime? selectedStartDateTime;
  DateTime? selectedEndDateTime;

  void initStartDate(DateTime selectedDateState) {
    startDateController.text = selectedDateState.monthWeekdayDay!;
    pickedStartDate = selectedDateState.resetTime;

    selectedStartDateTime = selectedDateState;
    startTimeController.text = selectedDateState.hmm!;
  }

  void initEndDate(DateTime selectedDateState) {
    endDateController.text = selectedDateState.monthWeekdayDay!;
    pickedEndDate = selectedDateState.resetTime;

    selectedEndDateTime = selectedDateState;
    endTimeController.text = selectedDateState.hmm!;
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
      initStartDate(widget.timeEntry!.startTime);
      if (widget.timeEntry!.endTime != null) {
        initEndDate(widget.timeEntry!.endTime!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 780,
        height: 507,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add Time Entry', style: TextStyle(fontSize: 22)),
              Gap(18),
              if (widget.projects != null) ...[
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
                    items: widget.projects!.map((e) {
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
                Gap(12),
              ],
              Row(
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
                              selectedStartDateTime ?? widget.selectedDate,
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
                            startDateController.text =
                                pickedDate.monthWeekdayDay!;
                          }
                        });
                      },
                    ),
                  ),
                  Gap(8),
                  Flexible(
                    child: Form(
                      key: formKey,
                      child: AppTextFormField(
                        controller: startTimeController,
                        label: 'time',
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '*Required';
                          }
                          return null;
                        },
                        onTap: (focusNode) {
                          showTimePicker(
                            context: context,
                            initialTime: selectedStartDateTime != null
                                ? TimeOfDay.fromDateTime(selectedStartDateTime!)
                                : TimeOfDay.now(),
                            initialEntryMode: TimePickerEntryMode.inputOnly,
                          ).then((pickedTime) async {
                            if (pickedTime != null) {
                              selectedStartDateTime = pickedStartDate!.add(
                                Duration(
                                  hours: pickedTime.hour,
                                  minutes: pickedTime.minute,
                                ),
                              );
                              startTimeController.text =
                                  selectedStartDateTime.hmm!;
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Gap(12),
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
                            endDateController.text =
                                pickedDate.monthWeekdayDay!;
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
                            selectedEndDateTime ?? DateTime.now(),
                          ),
                          initialEntryMode: TimePickerEntryMode.inputOnly,
                        ).then((pickedTime) async {
                          if (pickedTime != null) {
                            selectedEndDateTime = pickedEndDate!.add(
                              Duration(
                                hours: pickedTime.hour,
                                minutes: pickedTime.minute,
                              ),
                            );
                            endTimeController.text = selectedEndDateTime.hmm!;
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),

              Gap(35),
              AppTextFormField(
                controller: descriptionController,
                hint: 'Enter description (optional)',
                minLines: 3,
                maxLines: 4,
              ),
              Spacer(),
              Gap(16),
              Row(
                children: [
                  Expanded(
                    child: AppElevatedButton(
                      onPressed: widget.projects != null && projectID == null
                          ? null
                          : () {
                              if (!formKey.currentState!.validate()) return;
                              final timeEntry = TimeEntryForm(
                                id: widget.timeEntry?.id,
                                startDate: selectedStartDateTime!,
                                endDate: selectedEndDateTime,
                                projectID: projectID,
                                description: descriptionController.text,
                                createAt: widget.timeEntry?.createAt,
                              );
                              widget.onPressedSubmit(timeEntry);
                              context.pop();
                            },
                      title: 'Submit',
                    ),
                  ),
                  Gap(8),
                  TextButton(
                    onPressed: () => context.pop(),
                    child: Text('Cancel'),
                  ),
                  if (widget.onPressedDelete != null) ...[
                    Gap(28),
                    DeleteEventButton(onPressedDelete: widget.onPressedDelete),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
