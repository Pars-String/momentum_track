import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum_track/features/project_details/presentation/bloc/details_bloc.dart';

class ChangeDateButton extends StatelessWidget {
  final int projectID;
  const ChangeDateButton({required this.projectID, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            showDatePicker(
              context: context,
              initialDate: state.selectedDate,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            ).then((value) async {
              if (value != null && context.mounted) {
                context.read<DetailsBloc>().add(InitDateList(date: value));
                context.read<DetailsBloc>().add(
                  SelectNewDate(date: value, projectID: projectID),
                );
              }
            });
          },
          tooltip: 'Change date',
          icon: Icon(Icons.calendar_month_rounded),
        );
      },
    );
  }
}
