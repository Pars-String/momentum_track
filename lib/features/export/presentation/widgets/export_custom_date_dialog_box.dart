import 'dart:io';

import 'package:excel/excel.dart' hide Border;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/utils/helpers/calculating_helper.dart';
import 'package:momentum_track/core/widgets/app_elevated_button.dart';
import 'package:momentum_track/core/widgets/app_text_form_field.dart';
import 'package:momentum_track/features/export/presentation/cubit/report_cubit.dart';
import 'package:path/path.dart';

class ExportCustomDateDialogBox extends StatefulWidget {
  final BuildContext innerContext;
  const ExportCustomDateDialogBox({required this.innerContext, super.key});

  @override
  State<ExportCustomDateDialogBox> createState() =>
      _ExportCustomDateDialogBoxState();
}

class _ExportCustomDateDialogBoxState extends State<ExportCustomDateDialogBox> {
  final TextEditingController sDateController = TextEditingController();
  final TextEditingController eDateController = TextEditingController();
  final allFormKey = GlobalKey<FormState>();
  final startDateFormKey = GlobalKey<FormState>();
  int? projectID;
  DateTime? pickedStartDate;
  DateTime? pickedEndDate;

  @override
  void dispose() {
    sDateController.dispose();
    eDateController.dispose();
    super.dispose();
  }

  Future<void> exportProjectMonthlyReport(
    BuildContext context,
    List<TimeEntry> timeEntries,
    String projectName,
  ) async {
    if (timeEntries.isEmpty) {
      context.read<ReportCubit>().changeExportingStatus(ExportingFailure());
      return;
    }

    final chosenDirectory = await FilePicker.platform.getDirectoryPath();
    if (chosenDirectory == null) {
      if (context.mounted) {
        context.read<ReportCubit>().changeExportingStatus(ExportingFailure());
      }
      return;
    }

    final String now = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final String selectedStartDate = DateFormat(
      'dd MMMM',
    ).format(timeEntries.first.startTime);
    final String selectedEndDate = DateFormat(
      'dd MMMM',
    ).format(timeEntries.last.startTime);
    Duration totalDuration = Duration.zero;

    final excel = Excel.createExcel();
    final sheetsMap = excel.sheets;
    excel.rename(
      sheetsMap.keys.first,
      '$selectedStartDate/$selectedEndDate Report',
    );
    final sheet = excel['$selectedStartDate/$selectedEndDate Report'];

    sheet.merge(
      CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0),
      CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0),
      customValue: TextCellValue(
        'Momentum Track Report  -( $projectName / from $selectedStartDate to $selectedEndDate )-',
      ),
    );

    sheet.appendRow([
      TextCellValue('Date'),
      TextCellValue('Duration'),
      TextCellValue('Note'),
      TextCellValue('Start Time'),
      TextCellValue('End Time'),
    ]);

    for (final entry in timeEntries) {
      final duration = CalculatingHelper.convertHoursToDuration(
        entry.duration ?? 0,
      );
      totalDuration += duration;

      sheet.appendRow([
        DateCellValue.fromDateTime(entry.startTime),
        DoubleCellValue(entry.duration ?? 0),
        TextCellValue(entry.note ?? 'No Description'),
        TimeCellValue.fromTimeOfDateTime(entry.startTime),
        entry.endTime != null
            ? TimeCellValue.fromTimeOfDateTime(entry.endTime!)
            : TextCellValue('-'),
      ]);
    }

    sheet.appendRow([
      TextCellValue('Total Duration'),
      TextCellValue(
        '${totalDuration.inHours}h ${totalDuration.inMinutes.remainder(60)}m',
      ),
      TextCellValue(''),
      TextCellValue(''),
      TextCellValue(''),
    ]);

    var fileBytes = excel.save();

    final String fileName =
        '${projectName}_report_from_${selectedStartDate}_to_${selectedEndDate}_generated_$now.xlsx';
    final parent = Directory(chosenDirectory);
    final file = File(join(chosenDirectory, fileName));

    // Make sure the directory of the file exists
    if (!await parent.exists()) {
      await parent.create(recursive: true);
    }
    // However, the file itself must not exist
    if (await file.exists()) {
      await file.delete();
    }

    file
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes ?? []);
    if (context.mounted) {
      context.read<ReportCubit>().changeExportingStatus(ExportingSuccess());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.innerContext.read<ReportCubit>(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<ReportCubit, ReportState>(
            listener: (context, state) {
              if (state.reportingStatus is ReportingSuccess &&
                  state.exportingStatus is ExportingInitial) {
                context.read<ReportCubit>().changeExportingStatus(
                  ExportingLoading(),
                );

                final String projectName = state.projects
                    .firstWhere((element) => element.id == projectID)
                    .name;

                exportProjectMonthlyReport(
                  context,
                  (state.reportingStatus as ReportingSuccess).timeEntries,
                  projectName,
                );
              }
              if (state.exportingStatus is ExportingSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Report exported successfully')),
                );
                context
                  ..pop()
                  ..read<ReportCubit>().reset();
              }
              if (state.exportingStatus is ExportingFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Report exported failed')),
                );
                context
                  ..pop()
                  ..read<ReportCubit>().reset();
              }
            },
            builder: (context, state) {
              final List<Project> projects = state.projects;
              final isLoading =
                  state.reportingStatus is ReportingLoading ||
                  state.exportingStatus is ExportingLoading;

              return SimpleDialog(
                title: const Text('Export Report'),
                contentPadding: const EdgeInsets.all(16),

                children: [
                  if (isLoading)
                    CircularProgressIndicator.adaptive()
                  else ...[
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
                        items: projects.map((e) {
                          return DropdownMenuItem<int>(
                            value: e.id,
                            child: Text(e.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (!isLoading) {
                            projectID = value;
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    Gap(16),
                    Form(
                      key: allFormKey,
                      child: Column(
                        children: [
                          Form(
                            key: startDateFormKey,
                            child: AppTextFormField(
                              label: 'Select start date',
                              controller: sDateController,
                              readOnly: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a start date';
                                }
                                return null;
                              },
                              onTap: isLoading
                                  ? null
                                  : (focusNode) {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                      ).then((thisDate) async {
                                        if (thisDate != null) {
                                          sDateController.text =
                                              DateFormat.MMMMEEEEd().format(
                                                thisDate,
                                              );
                                          pickedStartDate = thisDate;
                                          eDateController.text = '';
                                          pickedEndDate = null;
                                          setState(() {});
                                        }
                                      });
                                    },
                            ),
                          ),

                          Gap(16),
                          AppTextFormField(
                            label: 'Select end date',
                            controller: eDateController,
                            readOnly: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select an end date';
                              }

                              return null;
                            },
                            onTap: isLoading || pickedStartDate == null
                                ? (focusNode) {
                                    FocusScope.of(context).unfocus();
                                    startDateFormKey.currentState!.validate();
                                    return;
                                  }
                                : (focusNode) {
                                    showDatePicker(
                                      context: context,
                                      initialDate: pickedStartDate!,
                                      firstDate: pickedStartDate!,
                                      lastDate: DateTime(2100),
                                    ).then((thisDate) async {
                                      if (thisDate != null) {
                                        eDateController.text =
                                            DateFormat.MMMMEEEEd().format(
                                              thisDate,
                                            );
                                        pickedEndDate = thisDate;
                                      }
                                    });
                                  },
                          ),

                          Gap(16),
                        ],
                      ),
                    ),
                  ],

                  Row(
                    children: [
                      Expanded(
                        child: AppElevatedButton(
                          onPressed: projectID == null || isLoading
                              ? null
                              : () async {
                                  if (allFormKey.currentState!.validate()) {
                                    context
                                        .read<ReportCubit>()
                                        .getCustomRangeTimeEntries(
                                          projectId: projectID!,
                                          sDate: pickedStartDate!,
                                          eDate: pickedEndDate!,
                                        );
                                  }
                                },
                          title: isLoading ? 'Please Wait...' : 'Generate',
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
          );
        },
      ),
    );
  }
}
