import 'package:app_todolist_desktop/features/todolist/domain/repositories/todolist_repository.dart';

class DeleteJobByStatusUseCase {
  final TodolistRepository repository;
  DeleteJobByStatusUseCase(this.repository);
  Future<void> call(String status) async =>
      await repository.deleteJobByStatus(status);
}
