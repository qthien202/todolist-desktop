import 'package:app_todolist_desktop/features/todolist/data/models/job.dart';

abstract class TodolistLocalDataSource {
  Future<List<JobModel>> getJobs();
  Future<void> addJob(JobModel job);
  Future<void> deleteJobById(String id);
  Future<void> updateJobById(int id, JobModel job);
}
