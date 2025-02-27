import 'package:app_todolist_desktop/features/todolist/domain/entities/job_entity.dart';

abstract class TodolistRepository {
  Future<void> addJob(JobEntity job);
  Future<List<JobEntity>> getJobs();
  Future<List<JobEntity>> getJobByStatus(String status);
  Future<void> updateJobById(int id, JobEntity job);
  Future<void> deleteJobById(int id);
  Future<void> deleteJobByStatus(String status);
}
