import 'package:app_todolist_desktop/features/todolist/domain/entities/job_entity.dart';

abstract class TodolistRepository {
  Future<void> addJob(JobEntity job);
  Future<List<JobEntity>> getJobs();
  Future<void> updateJobById(int id, JobEntity job);
  Future<void> deleteJobById(String id);
}
