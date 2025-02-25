import 'package:app_todolist_desktop/features/todolist/domain/entities/job_entity.dart';
import 'package:app_todolist_desktop/features/todolist/domain/repositories/todolist_repository.dart';

class GetJobByStatusUseCase {
  final TodolistRepository repository;
  GetJobByStatusUseCase(this.repository);

  Future<List<JobEntity>> call(String status) async =>
      await repository.getJobByStatus(status);
}
