import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:momentum_track/core/widgets/app_elevated_button.dart';
import 'package:momentum_track/features/reports/presentation/cubit/report_cubit.dart';
import 'package:momentum_track/features/reports/presentation/widgets/export_custom_date_dialog_box.dart';
import 'package:momentum_track/locator.dart';

class ExportCustomDateReport extends StatelessWidget {
  const ExportCustomDateReport({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportCubit(locator())..getAllProjects(),
      child: Builder(
        builder: (context) {
          return AppElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) {
                  return ExportCustomDateDialogBox(innerContext: context);
                },
              );
            },
            title: 'Save as Excel (custom date)',
            icon: HugeIcons.strokeRoundedFolderExport,
          );
        },
      ),
    );
  }
}
