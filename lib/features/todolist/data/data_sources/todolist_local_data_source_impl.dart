import 'package:app_todolist_desktop/features/todolist/data/data_sources/todolist_local_data_source.dart';
import 'package:app_todolist_desktop/features/todolist/data/models/job.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class TodolistLocalDataSourceImpl implements TodolistLocalDataSource {
  static const databaseName = "todolist_db";
  static const tableName = "todos";
  var databaseFactory = databaseFactoryFfi;
  static Database? _db;
  Future<Database> get database async => _db ??= await initDB();

  Future<Database> initDB() async {
    final dbPath = await databaseFactory.getDatabasesPath();
    final inMemoryDatabasePath = '$dbPath/$databaseName';
    _db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    await _db?.execute('''
      CREATE TABLE $tableName(
        id TEXT PRIMARY KEY,
        name TEXT,
        isDone BOOLEAN
      )
    ''');
    return _db!;
  }

  @override
  Future<void> addJob(JobModel job) async {
    final db = await database;
    await db.insert(tableName, job.toJson());
  }

  @override
  Future<List<JobModel>> getJobs() async {
    final db = await database;
    var res = await db.query(tableName);
    List<JobModel> jobs = res.map((e) => JobModel.fromJson(e)).toList();
    return jobs;
  }

  @override
  Future<void> updateJobById(String id, JobModel job) async {
    final db = await database;
    await db.update(tableName, job.toJson(), where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> deleteJobById(String id) async {
    final db = await database;
    await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
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
