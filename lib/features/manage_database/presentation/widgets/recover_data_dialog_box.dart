import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:momentum_track/core/bloc/global_data_flow/global_data_flow_cubit.dart';
import 'package:momentum_track/core/widgets/app_elevated_button.dart';
import 'package:momentum_track/core/widgets/app_toastification.dart';
import 'package:momentum_track/features/manage_database/presentation/cubit/manage_db_cubit.dart';
import 'package:momentum_track/locator.dart';

class RecoverDataDialogBox extends StatelessWidget {
  const RecoverDataDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManageDbCubit(locator()),
      child: Builder(
        builder: (context) {
          return BlocConsumer<ManageDbCubit, ManageDbState>(
            listener: (context, state) {
              if (state is ManageDbSuccess) {
                context.read<GlobalDataFlowCubit>()
                  ..updateHeatMapStatus(HeatMapStatus.needUpdate)
                  ..updateProjectOverviewStatus(OverviewStatus.needUpdate);
                context.pop();
                AppToastification.showInfo(
                  context,
                  description: 'Recover all data successfully',
                );
              }
            },
            builder: (context, state) {
              final isLoading = state is ManageDbLoading;

              return AlertDialog(
                title: Text('Notice'),
                contentPadding: EdgeInsets.all(16),
                content: isLoading
                    ? SizedBox(
                        height: 50,
                        width: 250,
                        child: Column(
                          children: [
                            CircularProgressIndicator.adaptive(),
                            Gap(8),
                            Text('Please wait...'),
                          ],
                        ),
                      )
                    : SizedBox(
                        width: 250,
                        child: Text(
                          'This action will be delete all your current data and replace them with your backup data that you provide.',
                        ),
                      ),
                actions: [
                  TextButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            context.pop();
                          },
                    child: Text('Cancel'),
                  ),
                  AppElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                            context.read<ManageDbCubit>().recoverData();
                          },
                    title: 'Continue',
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
