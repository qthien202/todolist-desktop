import 'package:app_todolist_desktop/features/todolist/data/models/job.dart';
import 'package:app_todolist_desktop/features/todolist/domain/repositories/todolist_repository.dart';

import '../../domain/entities/job_entity.dart';
import '../data_sources/data_source.dart';

class TodolistRepositoryImpl implements TodolistRepository {
  final TodolistLocalDataSource todolistLocalDataSource;
  TodolistRepositoryImpl(this.todolistLocalDataSource);

  @override
  Future<void> addJob(JobEntity job) async =>
      await todolistLocalDataSource.addJob(JobModel.fromEntity(job));

  @override
  Future<List<JobEntity>> getJobs() async {
    return await todolistLocalDataSource
        .getJobs()
        .then((value) => value.map((e) => e).toList());
  }

  @override
  Future<List<JobEntity>> getJobByStatus(String status) async {
    return await todolistLocalDataSource
        .getJobByStatus(status)
        .then((value) => value.map((e) => e).toList());
  }

  @override
  Future<void> updateJobById(int id, JobEntity job) async {
    return await todolistLocalDataSource.updateJobById(
        id, JobModel.fromEntity(job));
  }

  @override
  Future<void> deleteJobById(int id) async =>
      await todolistLocalDataSource.deleteJobById(id);

  @override
  Future<void> deleteJobByStatus(String status) async =>
      await todolistLocalDataSource.deleteJobByStatus(status);
}
