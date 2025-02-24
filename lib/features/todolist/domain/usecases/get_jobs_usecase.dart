import 'package:app_todolist_desktop/features/todolist/domain/repositories/todolist_repository.dart';

import '../entities/job_entity.dart';

class GetJobsUsecase {
  final TodolistRepository repository;
  GetJobsUsecase(this.repository);

  Future<List<JobEntity>> call() async => await repository.getJobs();
}
