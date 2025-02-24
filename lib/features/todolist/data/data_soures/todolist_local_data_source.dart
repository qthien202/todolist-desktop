import 'package:app_todolist_desktop/features/todolist/data/models/job.dart';

abstract class TodolistLocalDataSource {
  Future<List<JobModel>> getTodos();
  Future<void> addTodo(JobModel job);
  Future<void> deleteTodoById(String id);
  Future<void> updateTodoById(String id, JobModel job);
}
