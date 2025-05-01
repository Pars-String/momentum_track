import 'dart:io';

import 'package:drift/drift.dart';
import 'package:momentum_track/core/database/app_database.dart';
import 'package:momentum_track/core/utils/helpers/calculating_helper.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

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
    return (db.select(db.projects)
      ..where((tbl) => tbl.id.equals(projectID))).getSingle();
  }

  Future<void> updateProject(ProjectsCompanion project) async {
    await db.update(db.projects).replace(project);
  }

  Future<void> deleteProject(int id) async {
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

  Future<List<TimeEntry>> getTimeEntriesForOneMonth({
    required DateTime date,
    int? projectId,
  }) async {
    final DateTime eDate =
        CalculatingHelper.calculateLastDayOfMonth(date).gregorianLastDay;

    if (projectId != null) {
      return (db.select(db.timeEntries)
            ..where(
              (tbl) =>
                  tbl.startTime.isBetweenValues(
                    date.copyWith(day: 1, hour: 0, minute: 0, second: 0),
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
              date.copyWith(day: 1, hour: 0, minute: 0, second: 0),
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
    return (db.select(db.timeEntries)
      ..where((tbl) => tbl.projectId.equals(projectId))).get();
  }

  Future<void> updateTimeEntry(Insertable<TimeEntry> timeEntry) async {
    await db.update(db.timeEntries).replace(timeEntry);
  }

  Future<void> deleteTimeEntry(int id) async {
    await (db.delete(db.timeEntries)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> deleteDatabase() async {
    await db.close();
    final dbFolder = await getApplicationDocumentsDirectory();
    final dbPath = join(dbFolder.path, 'your_database_name.sqlite');
    final file = File(dbPath);

    if (await file.exists()) {
      await file.delete();
    }
  }
}
