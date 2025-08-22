import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/utils/helpers/date_helper.dart';
import 'package:momentum_track/features/project_details/repository/project_details_repository.dart';

part 'project_details_event.dart';
part 'project_details_state.dart';
part 'status/details_date_status.dart';
part 'status/project_time_entry_status.dart';

class ProjectDetailsBloc
    extends Bloc<ProjectDetailsEvent, ProjectDetailsState> {
  final ProjectDetailsRepository repository;
  ProjectDetailsBloc(this.repository)
    : super(
        ProjectDetailsState(
          detailsDateStatus: DetailsDateInitial(),
          projectTimeEntryStatus: TimeEntryInitial(),
          selectedDate: DateHelper.today(),
        ),
      ) {
    on<InitDateList>((event, emit) async {
      emit(state.copyWith(detailsDateStatus: DetailsDateLoading()));
      try {
        if (event.dateList.isNotEmpty) {
          emit(
            state.copyWith(
              detailsDateStatus: DetailsDateSuccess(dateList: event.dateList),
            ),
          );
        } else {
          emit(
            state.copyWith(
              detailsDateStatus: DetailsDateFailure(error: 'No dates found'),
            ),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(
            detailsDateStatus: DetailsDateFailure(error: 'No dates found'),
          ),
        );
      }
    });

    on<InitTimeEntriesList>((event, emit) async {
      emit(state.copyWith(projectTimeEntryStatus: TimeEntryLoading()));

      try {
        final List<TimeEntry> timeEntries = await repository.getTimeEntries(
          projectId: event.projectID,
          eDate: event.dateList.last,
          sDate: event.dateList.first,
        );

        emit(
          state.copyWith(
            projectTimeEntryStatus: TimeEntrySuccess(timeEntries: timeEntries),
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            projectTimeEntryStatus: TimeEntryFailure(error: e.toString()),
          ),
        );
      }
    });

    // on<SelectNewDate>((event, emit) async {
    //   final DateTime cache = state.selectedDate;

    //   emit(
    //     state.copyWith(
    //       selectedDate: event.date,
    //       projectTimeEntryStatus: TimeEntryLoading(),
    //     ),
    //   );

    //   try {
    //     final List<TimeEntry> timeEntries = await repository.getTimeEntries(
    //       projectId: event.projectID,
    //       selectedDate: event.date,
    //     );

    //     emit(
    //       state.copyWith(
    //         projectTimeEntryStatus: TimeEntrySuccess(timeEntries: timeEntries),
    //       ),
    //     );
    //   } catch (e) {
    //     emit(
    //       state.copyWith(
    //         selectedDate: cache,
    //         projectTimeEntryStatus: TimeEntryFailure(error: e.toString()),
    //       ),
    //     );
    //   }
    // });

    on<AddNewTimeEntry>((event, emit) async {
      final List<TimeEntry> timeEntries =
          state.projectTimeEntryStatus is TimeEntrySuccess
          ? (state.projectTimeEntryStatus as TimeEntrySuccess).timeEntries
          : [];
      emit(state.copyWith(projectTimeEntryStatus: TimeEntryLoading()));

      try {
        final TimeEntry item = await repository.addNewTimeEntry(
          projectId: event.projectID,
          note: event.note,
          startTime: event.startTime,
          endTime: event.endTime,
        );
        timeEntries.add(item);

        emit(
          state.copyWith(
            projectTimeEntryStatus: TimeEntrySuccess(timeEntries: timeEntries),
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            projectTimeEntryStatus: TimeEntryFailure(error: e.toString()),
          ),
        );
      }
    });

    on<EditTimeEntry>((event, emit) async {
      final List<TimeEntry> timeEntries =
          state.projectTimeEntryStatus is TimeEntrySuccess
          ? (state.projectTimeEntryStatus as TimeEntrySuccess).timeEntries
          : [];
      emit(state.copyWith(projectTimeEntryStatus: TimeEntryLoading()));
      final TimeEntry timeEntry = timeEntries.firstWhere(
        (element) => element.id == event.id,
      );

      try {
        final TimeEntry item = await repository.updateTimeEntry(
          timeEntry: timeEntry,
          note: event.note,
          startTime: event.startTime,
          endTime: event.endTime,
        );
        timeEntries
          ..remove(timeEntry)
          ..insert(0, item);

        emit(
          state.copyWith(
            projectTimeEntryStatus: TimeEntrySuccess(timeEntries: timeEntries),
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            projectTimeEntryStatus: TimeEntryFailure(error: e.toString()),
          ),
        );
      }
    });
  }
}
