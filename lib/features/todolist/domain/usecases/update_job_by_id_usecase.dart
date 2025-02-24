import '../entities/job_entity.dart';
import '../repositories/todolist_repository.dart';

class UpdateJobByIdUsecase {
  final TodolistRepository repository;
  UpdateJobByIdUsecase(this.repository);
  Future<void> call(String id, JobEntity job) async =>
      await repository.updateJobById(id, job);
}
