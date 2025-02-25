import 'package:app_todolist_desktop/features/todolist/domain/repositories/todolist_repository.dart';

class DeleteJobByIdUsecase {
  final TodolistRepository repository;
  DeleteJobByIdUsecase(this.repository);
  Future<void> call(int id) async => await repository.deleteJobById(id);
}
