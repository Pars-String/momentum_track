import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:momentum_track/core/database/schema_versions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Projects, TimeEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: stepByStep(
        // from1To2: (m, schema) async {
        //   await m.addColumn(publicInfos, publicInfos.first_launch);
        // },
        // from2To3: (m, schema) async {
        //   await m.addColumn(publicInfos, publicInfos.other);
        // },
      ),
      beforeOpen: (openingDetails) async {
        await customStatement(
          'PRAGMA foreign_keys = ON',
        ); // Enable foreign key references in sqlite3.
      },
    );
  }

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

/// how to generate migration steps
/// 
/// at first please change anything you want to change in the database then
/// increase the app version, add migration strategy and run the following code
/// 
/// to update all tables run:
/// `dart run build_runner build`
/// 
/// after that to generate a new schemas run:
/// `dart run drift_dev schema dump lib/core/database/app_database.dart lib/core/database/drift_schemas/`
/// 
/// at the end run this code to create a new steps:
/// `dart run drift_dev schema steps lib/core/database/drift_schemas/ lib/core/database/schema_versions.dart`
