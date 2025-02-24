import 'dart:convert';

import 'package:app_todolist_desktop/features/todolist/data/data_soures/todolist_local_data_source.dart';
import 'package:app_todolist_desktop/features/todolist/data/models/job.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class TodolistLocalDataSourceImpl implements TodolistLocalDataSource {
  static const databaseName = "todolist_db";
  static const tableName = "todos";
  static Database? _database;

  Future<Database> get database async => _database ??= await initDB();
  initDB() async {
    final database = openDatabase(
      join(await getDatabasesPath(), databaseName),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $tableName(id TEXT PRIMARY KEY, name TEXT)",
        );
      },
    );
    return database;
  }

  @override
  Future<void> addTodo(JobModel job) async {
    final db = await database;
    await db.insert(tableName, job.toJson());
  }

  @override
  Future<List<JobModel>> getTodos() async {
    final db = await database;
    var res = await db.query(tableName);
    List<JobModel> jobs = res.map((e) => JobModel.fromJson(e)).toList();
    return jobs;
  }

  @override
  Future<void> updateTodoById(String id, JobModel job) async {
    final db = await database;
    await db.update(tableName, job.toJson(), where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> deleteTodoById(String id) async {
    final db = await database;
    await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
