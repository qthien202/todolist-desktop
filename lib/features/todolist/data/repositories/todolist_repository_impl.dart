// import 'package:app_todolist_desktop/features/todolist/data/data_soures/todolist_local_data_source.dart';
// import 'package:app_todolist_desktop/features/todolist/data/models/job.dart';
// import 'package:app_todolist_desktop/features/todolist/domain/repositories/todolist_repository.dart';

// import '../../domain/entities/job_entity.dart';

// class TodolistRepositoryImpl implements TodolistRepository {
//   final TodolistLocalDataSource todolistLocalDataSource;
//   TodolistRepositoryImpl(this.todolistLocalDataSource);

//   @override
//   Future<void> addTodo(JobEntity job) async =>
//       await todolistLocalDataSource.addTodo(JobModel.fromEntity(job));

//   @override
//   Future<List<JobEntity>> getTodos() async {
//     return await todolistLocalDataSource
//         .getTodos()
//         .then((value) => value.map((e) => e).toList());
//   }

//   @override
//   Future<void> updateTodoById(String id, JobEntity job) async {
//     return await todolistLocalDataSource.updateTodoById(
//         id, JobModel.fromEntity(job));
//   }

//   @override
//   Future<void> deleteTodoById(String id) async =>
//       await todolistLocalDataSource.deleteTodoById(id);
// }
