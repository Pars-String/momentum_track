import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:momentum_track/core/data/models/time_entry_form.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/features/project_details/repository/project_details_repository.dart';

part 'project_details_event.dart';
part 'project_details_state.dart';
part 'status/project_details_status.dart';

class ProjectDetailsBloc
    extends Bloc<ProjectDetailsEvent, ProjectDetailsState> {
  final ProjectDetailsRepository repository;
  ProjectDetailsBloc(this.repository)
    : super(
        ProjectDetailsState(
          projectDetailsStatus: ProjectDetailsInitial(),
          addOrEditTimeEntryStatus: AddOrEditTimeEntryStatus.initial,
          dates: [],
          timeEntries: [],
        ),
      ) {
    on<InitProjectDetails>(_onInitProjectDetails);
    on<AddNewTimeEntry>(_addNewTimeEntry);
    on<EditTimeEntry>(_editTimeEntry);
    on<DeleteTimeEntry>(_deleteTimeEntry);

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
  }

  void _onInitProjectDetails(
    InitProjectDetails event,
    Emitter<ProjectDetailsState> emit,
  ) async {
    final List<DateTime> dates = event.thisMonthDates;

    emit(state.copyWith(projectDetailsStatus: ProjectDetailsLoading()));

    final project = await repository.getProject(event.projectID);
    final timeEntries = await repository.getTimeEntries(
      projectId: event.projectID,
      sDate: dates.first,
      eDate: dates.last,
    );

    // if (dates.isNotEmpty) {
    //   await repository
    //       .getTimeEntries(
    //         projectId: event.projectID,
    //         sDate: dates.first,
    //         eDate: dates.last,
    //       )
    //       .then((value) {
    //         timeEntries.addAll(value);
    //       });
    // }

    emit(
      state.copyWith(
        projectDetailsStatus: ProjectDetailsSuccess(projectInfo: project),
        addOrEditTimeEntryStatus: AddOrEditTimeEntryStatus.success,
        timeEntries: timeEntries,
        dates: dates,
      ),
    );
  }

  void _addNewTimeEntry(
    AddNewTimeEntry event,
    Emitter<ProjectDetailsState> emit,
  ) async {
    final List<TimeEntry> timeEntries = state.timeEntries;
    emit(
      state.copyWith(
        addOrEditTimeEntryStatus: AddOrEditTimeEntryStatus.loading,
      ),
    );

    try {
      final TimeEntry item = await repository.addNewTimeEntry(
        timeEntry: event.timeEntry,
      );

      timeEntries
        ..add(item)
        ..sort((a, b) => b.startTime.compareTo(a.startTime));

      emit(
        state.copyWith(
          timeEntries: timeEntries,
          addOrEditTimeEntryStatus: AddOrEditTimeEntryStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          addOrEditTimeEntryStatus: AddOrEditTimeEntryStatus.failure,
        ),
      );
    }
  }

  void _editTimeEntry(
    EditTimeEntry event,
    Emitter<ProjectDetailsState> emit,
  ) async {
    final List<TimeEntry> timeEntries = state.timeEntries;
    emit(
      state.copyWith(
        addOrEditTimeEntryStatus: AddOrEditTimeEntryStatus.loading,
      ),
    );

    try {
      final TimeEntry item = await repository.updateTimeEntry(
        timeEntry: event.timeEntry,
      );
      final int index = timeEntries.indexWhere(
        (element) => element.id == event.timeEntry.id,
      );

      timeEntries
        ..removeAt(index)
        ..insert(index, item);

      emit(
        state.copyWith(
          timeEntries: timeEntries,
          addOrEditTimeEntryStatus: AddOrEditTimeEntryStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          addOrEditTimeEntryStatus: AddOrEditTimeEntryStatus.failure,
        ),
      );
    }
  }

  void _deleteTimeEntry(
    DeleteTimeEntry event,
    Emitter<ProjectDetailsState> emit,
  ) async {
    final List<TimeEntry> timeEntries = state.timeEntries;
    emit(
      state.copyWith(
        addOrEditTimeEntryStatus: AddOrEditTimeEntryStatus.loading,
      ),
    );

    try {
      await repository.deleteTimeEntry(event.timeEntryID);

      final int index = timeEntries.indexWhere(
        (element) => element.id == event.timeEntryID,
      );

      timeEntries.removeAt(index);

      emit(
        state.copyWith(
          timeEntries: timeEntries,
          addOrEditTimeEntryStatus: AddOrEditTimeEntryStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          addOrEditTimeEntryStatus: AddOrEditTimeEntryStatus.failure,
        ),
      );
    }
  }
}
