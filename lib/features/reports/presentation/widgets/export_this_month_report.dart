import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:momentum_track/core/widgets/app_elevated_button.dart';
import 'package:momentum_track/features/reports/presentation/cubit/report_cubit.dart';
import 'package:momentum_track/features/reports/presentation/widgets/export_this_month_dialog_box.dart';
import 'package:momentum_track/locator.dart';

class ExportThisMonthReport extends StatelessWidget {
  const ExportThisMonthReport({super.key});

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
                  return ExportThisMonthDialogBox(innerContext: context);
                },
              );
            },
            title: 'Save as Excel (this month)',
            icon: HugeIcons.strokeRoundedFolderExport,
          );
        },
      ),
    );
  }
}
