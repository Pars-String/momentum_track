import 'package:momentum_track/core/data/models/time_entry_form.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/features/date_details/data/date_details_local_provider.dart';

class DateDetailsRepository {
  final DateDetailsLocalProvider dbProvider;

  DateDetailsRepository(this.dbProvider);

  Future<TimeEntry> addNewTimeEntry({
    required TimeEntryForm timeEntryForm,
  }) async {
    return await dbProvider.addNewTimeEntry(timeEntryForm: timeEntryForm);
  }

  Future<TimeEntry> updateTimeEntry({
    required TimeEntry timeEntry,
    required TimeEntryForm timeEntryForm,
  }) async {
    return await dbProvider.updateTimeEntry(
      timeEntry: timeEntry,
      timeEntryForm: timeEntryForm,
    );
  }

  Future<void> deleteTimeEntry({required int timeEntryID}) async {
    return await dbProvider.deleteTimeEntry(timeEntryID);
  }

  Future<List<Project>> getAllProjects() async {
    return await dbProvider.getAllProjects();
  }

  Future<List<TimeEntry>> getTimeEntriesForOneDay({
    required DateTime selectedDate,
  }) async {
    return await dbProvider.getTimeEntriesForOneDay(selectedDate: selectedDate);
  }
}
