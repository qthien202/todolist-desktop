import 'package:app_todolist_desktop/features/todolist/data/models/job.dart';

abstract class TodolistLocalDataSource {
  Future<List<JobModel>> getJobs();
  Future<List<JobModel>> getJobByStatus(String status);
  Future<void> addJob(JobModel job);
  Future<void> deleteJobById(int id);
  Future<void> updateJobById(int id, JobModel job);
}
