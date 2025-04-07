import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:momentum_track/core/constant/app_constant.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/utils/helpers/calculating_helper.dart';
import 'package:momentum_track/features/project_details/repository/details_repository.dart';

part 'details_event.dart';
part 'details_state.dart';
part 'status/details_date_status.dart';
part 'status/project_time_entry_status.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final DetailsRepository repository;
  DetailsBloc(this.repository)
    : super(
        DetailsState(
          detailsDateStatus: DetailsDateInitial(),
          projectTimeEntryStatus: TimeEntryInitial(),
          selectedDate: CalculatingHelper.today(),
        ),
      ) {
    on<InitDateList>((event, emit) async {
      emit(state.copyWith(detailsDateStatus: DetailsDateLoading()));
      try {
        final List<DateTime> dateList = await repository.getDateList(
          event.date,
        );

        if (dateList.isNotEmpty) {
          emit(
            state.copyWith(
              detailsDateStatus: DetailsDateSuccess(dateList: dateList),
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
          selectedDate: state.selectedDate,
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

    on<SelectNewDate>((event, emit) async {
      final DateTime cache = state.selectedDate;

      emit(
        state.copyWith(
          selectedDate: event.date,
          projectTimeEntryStatus: TimeEntryLoading(),
        ),
      );

      try {
        final List<TimeEntry> timeEntries = await repository.getTimeEntries(
          projectId: event.projectID,
          selectedDate: event.date,
        );

        emit(
          state.copyWith(
            projectTimeEntryStatus: TimeEntrySuccess(timeEntries: timeEntries),
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            selectedDate: cache,
            projectTimeEntryStatus: TimeEntryFailure(error: e.toString()),
          ),
        );
      }
    });

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
