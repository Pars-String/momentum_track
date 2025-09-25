import 'dart:io';

import 'package:drift/drift.dart';
import 'package:file_picker/file_picker.dart';
import 'package:momentum_track/core/constant/app_versions.dart';
import 'package:momentum_track/core/data/models/time_entry_form.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:path/path.dart';

class DatabaseService {
  final AppDatabase db;
  DatabaseService(this.db);

  Future<void> insertProject(ProjectsCompanion project) async {
    await db.into(db.projects).insert(project);
  }

  Future<List<Project>> getAllProjects() async {
    return await db.select(db.projects).get();
  }

  Future<Project> getProject(int projectID) async {
    return (db.select(
      db.projects,
    )..where((tbl) => tbl.id.equals(projectID))).getSingle();
  }

  Future<void> updateProject(ProjectsCompanion project) async {
    await db.update(db.projects).replace(project);
  }

  Future<void> deleteProject(int id) async {
    await (db.delete(
      db.timeEntries,
    )..where((tbl) => tbl.projectId.equals(id))).go();
    await (db.delete(db.projects)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> insertTimeEntry(TimeEntriesCompanion timeEntry) async {
    return await db.into(db.timeEntries).insert(timeEntry);
  }

  Future<List<TimeEntry>> getAllTimeEntries({
    required int projectId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final DateTime sDate = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
      0,
      0,
      0,
    );
    final DateTime eDate = DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
      23,
      59,
      59,
    );

    return (db.select(db.timeEntries)
          ..where((tbl) => tbl.projectId.equals(projectId))
          ..where((tbl) => tbl.startTime.isBetweenValues(sDate, eDate))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.startTime)]))
        .get();
  }

  Future<List<TimeEntry>> getTimeEntriesForOneDay({
    required int projectId,
    required DateTime date,
  }) async {
    final DateTime sDate = DateTime(date.year, date.month, date.day, 0, 0, 0);
    final DateTime eDate = DateTime(
      date.year,
      date.month,
      date.day,
      23,
      59,
      59,
    );

    return (db.select(db.timeEntries)
          ..where((tbl) => tbl.projectId.equals(projectId))
          ..where((tbl) => tbl.startTime.isBetweenValues(sDate, eDate))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.startTime)]))
        .get();
  }

  Future<List<TimeEntry>> getAllProjectsTimeEntriesForOneDay({
    required DateTime date,
  }) async {
    final DateTime sDate = DateTime(date.year, date.month, date.day, 0, 0, 0);
    final DateTime eDate = DateTime(
      date.year,
      date.month,
      date.day,
      23,
      59,
      59,
    );

    return (db.select(db.timeEntries)
          ..where((tbl) => tbl.startTime.isBetweenValues(sDate, eDate))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.startTime)]))
        .get();
  }

  Future<List<TimeEntry>> getTimeEntriesForSpecificDate({
    required DateTime eDate,
    required DateTime sDate,
    int? projectId,
  }) async {
    if (projectId != null) {
      return (db.select(db.timeEntries)
            ..where(
              (tbl) =>
                  tbl.startTime.isBetweenValues(
                    sDate.copyWith(hour: 0, minute: 0, second: 0),
                    eDate.copyWith(hour: 23, minute: 59, second: 59),
                  ) &
                  tbl.projectId.equals(projectId),
            )
            ..orderBy([(tbl) => OrderingTerm.desc(tbl.startTime)]))
          .get();
    }
    return (db.select(db.timeEntries)
          ..where(
            (tbl) => tbl.startTime.isBetweenValues(
              sDate.copyWith(hour: 0, minute: 0, second: 0),
              eDate.copyWith(hour: 23, minute: 59, second: 59),
            ),
          )
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.startTime)]))
        .get();
  }

  Future<List<TimeEntry>> getTimeEntriesForOneMonthByProjectID({
    required int projectId,
    required DateTime sDate,
    required DateTime eDate,
  }) async {
    return (db.select(db.timeEntries)
          ..where((tbl) => tbl.projectId.equals(projectId))
          ..where(
            (tbl) => tbl.startTime.isBetweenValues(
              sDate.copyWith(day: 1, hour: 0, minute: 0, second: 0),
              eDate.copyWith(hour: 23, minute: 59, second: 59),
            ),
          )
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.startTime)]))
        .get();
  }

  Future<List<TimeEntry>> getAllTimeEntriesByProjectID({
    required int projectId,
  }) async {
    return (db.select(
      db.timeEntries,
    )..where((tbl) => tbl.projectId.equals(projectId))).get();
  }

  Future<void> updateTimeEntry(Insertable<TimeEntry> timeEntry) async {
    await db.update(db.timeEntries).replace(timeEntry);
  }

  Future<void> updateTimeEntryNew(TimeEntryForm timeEntryForm) async {
    await (db.update(
      db.timeEntries,
    )..where((tbl) => tbl.id.isValue(timeEntryForm.id!))).write(
      TimeEntriesCompanion(
        note: Value(timeEntryForm.description),
        startTime: Value(timeEntryForm.startDate),
        endTime: Value(timeEntryForm.endDate),
        duration: Value(timeEntryForm.duration),
      ),
    );
  }

  Future<void> deleteTimeEntry(int id) async {
    await (db.delete(db.timeEntries)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> clearDatabase() async {
    await db.customStatement('PRAGMA foreign_keys = OFF;');

    for (final table in db.allTables) {
      await db.delete(table).go();
    }

    await db.customStatement('PRAGMA foreign_keys = ON;');
  }

  Future<bool> createDatabaseBackup() async {
    final chosenDirectory = await FilePicker.platform.getDirectoryPath();
    if (chosenDirectory == null) return false;

    final String fileName =
        'momentum_${DateTime.now().toIso8601String()}_${AppVersions.dbSchemaVersion}.sqlite';
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

    await db.customStatement('VACUUM INTO ?', [file.absolute.path]);
    return true;
  }
}
