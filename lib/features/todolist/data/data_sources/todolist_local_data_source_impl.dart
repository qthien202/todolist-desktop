import 'package:app_todolist_desktop/features/todolist/data/data_sources/todolist_local_data_source.dart';
import 'package:app_todolist_desktop/features/todolist/data/models/job.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io';
import 'package:path/path.dart';

class TodolistLocalDataSourceImpl implements TodolistLocalDataSource {
  static const databaseName = "todolist_db";
  static const tableName = "todos";
  var databaseFactory = databaseFactoryFfi;
  static Database? _db;
  Future<Database> get database async => _db ??= await initDB();

  Future<Database> initDB() async {
    final programDataPath = Directory('C:\\ProgramData\\TodoList');

    if (!programDataPath.existsSync()) {
      programDataPath.createSync(recursive: true);
    }

    final dbPath = join(programDataPath.path, databaseName);
    if (kDebugMode) {
      print("Database path: $dbPath");
    } // Kiểm tra đường dẫn

    final inMemoryDatabasePath = '$dbPath/$databaseName';
    _db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    await _db?.execute('''
      CREATE TABLE IF NOT EXISTS $tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        status TEXT,
        priority TEXT
      )
    ''');
    return _db!;
  }

  @override
  Future<void> addJob(JobModel job) async {
    final db = await database;
    await db.insert(
      tableName,
      job.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<JobModel>> getJobs() async {
    final db = await database;
    var res = await db.query(tableName);
    List<JobModel> jobs = res.map((e) => JobModel.fromJson(e)).toList();
    return jobs;
  }

  @override
  Future<List<JobModel>> getJobByStatus(String status) async {
    final db = await database;
    var res = await db.query(tableName, where: 'status=?', whereArgs: [status]);
    List<JobModel> jobs = res.map((e) => JobModel.fromJson(e)).toList();
    return jobs;
  }

  @override
  Future<void> updateJobById(int id, JobModel job) async {
    final db = await database;
    await db.update(tableName, job.toJson(), where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> deleteJobById(int id) async {
    final db = await database;
    await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> deleteJobByStatus(String status) async {
    final db = await database;
    await db.delete(tableName, where: 'status = ?', whereArgs: [status]);
  }

  //sqlflite

  // Future<Database> get database async => _database ??= await initDB();
  // initDB() async {
  //   final database = openDatabase(
  //     join(await getDatabasesPath(), databaseName),
  //     onCreate: (db, version) {
  //       return db.execute(
  //         "CREATE TABLE $tableName(id TEXT PRIMARY KEY, name TEXT, isDone BOOLEAN)",
  //       );
  //     },
  //   );
  //   return database;
  // }
}
