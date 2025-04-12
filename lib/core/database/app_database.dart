import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:momentum_track/core/constant/app_versions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Projects, TimeEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => AppVersions.dbSchemaVersion;

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final file = await databaseFile;
      return NativeDatabase(file, logStatements: true);
    });
  }
}

Future<File> get databaseFile async {
  // We use `path_provider` to find a suitable path to store our data in.
  final appDir = await getApplicationDocumentsDirectory();
  final dbPath = join(appDir.path, 'momentum_db.sqlite');
  return File(dbPath);
}

class Projects extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  DateTimeColumn get startDate => dateTime().nullable()();
  DateTimeColumn get createAt => dateTime()();
  TextColumn get description => text().nullable()();
}

class TimeEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime().nullable()();
  DateTimeColumn get createAt => dateTime()();
  TextColumn get note => text().nullable()();
  RealColumn get duration => real().nullable()();
  IntColumn get projectId => integer().references(Projects, #id)();
}
