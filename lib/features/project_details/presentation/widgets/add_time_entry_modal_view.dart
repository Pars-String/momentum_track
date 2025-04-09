import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/widgets/app_elevated_button.dart';
import 'package:momentum_track/core/widgets/app_text_form_field.dart';
import 'package:momentum_track/features/project_details/presentation/bloc/details_bloc.dart';

class AddTimeEntryModalView extends StatefulWidget {
  final int projectID;
  final BuildContext innerContext;
  final TimeEntry? timeEntry;
  const AddTimeEntryModalView({
    required this.innerContext,
    required this.projectID,
    this.timeEntry,
    super.key,
  });

  @override
  State<AddTimeEntryModalView> createState() => _AddTimeEntryModalViewState();
}

class _AddTimeEntryModalViewState extends State<AddTimeEntryModalView> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final startTimeFormKey = GlobalKey<FormState>();
  final allFormKey = GlobalKey<FormState>();

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
      value: widget.innerContext.read<DetailsBloc>(),
      child: Builder(
        builder: (context) {
          return BlocBuilder<DetailsBloc, DetailsState>(
            buildWhen: (p, c) => p.selectedDate != c.selectedDate,
            builder: (context, state) {
              if (widget.timeEntry == null && !hasInitialized) {
                initStartDate(state.selectedDate);
              }

              return Form(
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
                                      state.selectedDate,
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
                                    startDateController
                                        .text = DateFormat.MMMMEEEEd().format(
                                      pickedDate,
                                    );
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
                                  if (value == null || value.isEmpty) {
                                    return '*Required';
                                  }
                                  return null;
                                },
                                onTap: (focusNode) {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.fromDateTime(
                                      selectedStartDateTime ??
                                          state.selectedDate,
                                    ),
                                    initialEntryMode:
                                        TimePickerEntryMode.inputOnly,
                                  ).then((pickedTime) async {
                                    if (pickedTime != null) {
                                      selectedStartDateTime = pickedStartDate!
                                          .add(
                                            Duration(
                                              hours: pickedTime.hour,
                                              minutes: pickedTime.minute,
                                            ),
                                          );
                                      startTimeController.text = DateFormat(
                                        'h:mm a',
                                      ).format(selectedStartDateTime!);
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
                                  endDateController.text =
                                      DateFormat.MMMMEEEEd().format(pickedDate);
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
                    Row(
                      children: [
                        Expanded(
                          child: AppElevatedButton(
                            onPressed: () {
                              if (widget.timeEntry != null) {
                                if (startTimeFormKey.currentState!.validate()) {
                                  context.read<DetailsBloc>().add(
                                    EditTimeEntry(
                                      id: widget.timeEntry!.id,
                                      note: descriptionController.text,
                                      startTime: selectedStartDateTime!,
                                      endTime: selectedEndDateTime,
                                    ),
                                  );
                                  context.pop();
                                }
                              } else {
                                if (startTimeFormKey.currentState!.validate()) {
                                  context.read<DetailsBloc>().add(
                                    AddNewTimeEntry(
                                      projectID: widget.projectID,
                                      note: descriptionController.text,
                                      startTime: selectedStartDateTime!,
                                      endTime: selectedEndDateTime,
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
              );
            },
          );
        },
      ),
    );
  }
}
