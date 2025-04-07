import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
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
  DateTime? selectedStartTime;
  DateTime? selectedEndTime;

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.timeEntry != null) {
      descriptionController.text = widget.timeEntry!.note ?? '';
      selectedStartTime = widget.timeEntry!.startTime;
      selectedEndTime = widget.timeEntry!.endTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.innerContext.read<DetailsBloc>(),
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              AppTextFormField(
                controller: descriptionController,
                label: 'Description',
                hint: 'Enter description',
                minLines: 3,
              ),
              Gap(8),
              TextButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  ).then((value) async {
                    if (value != null && context.mounted) {
                      // Pick the time
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                          selectedStartTime ?? DateTime.now(),
                        ),
                      );

                      if (pickedTime != null) {
                        // Combine the date and time
                        final DateTime dateTime = DateTime(
                          value.year,
                          value.month,
                          value.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );
                        // Set the selected start time
                        selectedStartTime = dateTime;
                        setState(() {});
                      }
                    }
                  });
                },
                child: Text(
                  selectedStartTime == null
                      ? 'Select start date'
                      : 'Start at ${selectedStartTime!.toLocal()}',
                ),
              ),
              Gap(8),
              TextButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  ).then((value) async {
                    if (value != null && context.mounted) {
                      // Pick the time
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                          selectedEndTime ?? DateTime.now(),
                        ),
                      );

                      if (pickedTime != null) {
                        // Combine the date and time
                        final DateTime dateTime = DateTime(
                          value.year,
                          value.month,
                          value.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );
                        // Set the selected start time
                        selectedEndTime = dateTime;
                        setState(() {});
                      }
                    }
                  });
                },
                child: Text(
                  selectedEndTime == null
                      ? 'Select end date (Optional)'
                      : 'Start at ${selectedEndTime!.toLocal()}',
                ),
              ),
              Gap(16),
              Row(
                children: [
                  Expanded(
                    child: AppElevatedButton(
                      onPressed:
                          selectedStartTime == null
                              ? null
                              : () {
                                if (widget.timeEntry != null) {
                                  context.read<DetailsBloc>().add(
                                    EditTimeEntry(
                                      id: widget.timeEntry!.id,
                                      note: descriptionController.text,
                                      startTime: selectedStartTime!,
                                      endTime: selectedEndTime,
                                    ),
                                  );
                                } else {
                                  context.read<DetailsBloc>().add(
                                    AddNewTimeEntry(
                                      projectID: widget.projectID,
                                      note: descriptionController.text,
                                      startTime: selectedStartTime!,
                                      endTime: selectedEndTime,
                                    ),
                                  );
                                }
                                context.pop();
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
          );
        },
      ),
    );
  }
}
