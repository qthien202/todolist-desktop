import 'package:app_todolist_desktop/features/todolist/domain/entities/job_entity.dart';
import 'package:app_todolist_desktop/features/todolist/domain/repositories/todolist_repository.dart';

class AddJobUsecase {
  final TodolistRepository repository;
  AddJobUsecase(this.repository);
  Future<void> call(JobEntity job) async => await repository.addJob(job);
}
