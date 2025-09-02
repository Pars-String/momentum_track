import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:momentum_track/core/data/models/time_entry_form.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/features/date_details/repository/date_details_repository.dart';

part 'date_details_event.dart';
part 'date_details_state.dart';

class DateDetailsBloc extends Bloc<DateDetailsEvent, DateDetailsState> {
  final DateDetailsRepository repository;
  DateDetailsBloc(this.repository) : super(DateDetailsState()) {
    on<InitialDetails>((event, emit) async {
      final List<TimeEntry> timeEntries = [];
      final List<Project> projects = [];

      emit(state.copyWith(dateDetailsStatus: DateDetailsStatus.loading));

      await repository.getAllProjects().then((value) {
        projects.addAll(value);
      });

      await repository
          .getTimeEntriesForOneDay(selectedDate: event.selectedDate)
          .then((value) {
            timeEntries.addAll(value);
          });

      emit(
        state.copyWith(
          dateDetailsStatus: DateDetailsStatus.success,
          timeEntries: timeEntries,
          projects: projects,
        ),
      );
    });

    on<AddNewTimeEntry>((event, emit) async {
      final List<TimeEntry> timeEntries = state.timeEntries;
      emit(state.copyWith(dateDetailsStatus: DateDetailsStatus.loading));

      try {
        final TimeEntry item = await repository.addNewTimeEntry(
          timeEntryForm: event.timeEntryForm,
        );
        timeEntries.add(item);

        emit(
          state.copyWith(
            dateDetailsStatus: DateDetailsStatus.success,
            timeEntries: timeEntries,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            dateDetailsStatus: DateDetailsStatus.success,
            timeEntries: timeEntries,
          ),
        );
      }
    });

    on<EditTimeEntry>((event, emit) async {
      emit(state.copyWith(dateDetailsStatus: DateDetailsStatus.loading));

      final List<TimeEntry> timeEntries = state.timeEntries;
      final TimeEntry timeEntry = timeEntries.firstWhere(
        (element) => element.id == event.timeEntryForm.id,
      );
      final int index = timeEntries.indexOf(timeEntry);

      try {
        final TimeEntry updatedTimeEntry = await repository.updateTimeEntry(
          timeEntry: timeEntry,
          timeEntryForm: event.timeEntryForm,
        );

        timeEntries
          ..remove(timeEntry)
          ..insert(index, updatedTimeEntry);

        emit(
          state.copyWith(
            dateDetailsStatus: DateDetailsStatus.success,
            timeEntries: timeEntries,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            dateDetailsStatus: DateDetailsStatus.success,
            timeEntries: timeEntries,
          ),
        );
      }
    });
  }
}
