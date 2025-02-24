import 'package:app_todolist_desktop/features/todolist/data/data_soures/data_source.dart';
import 'package:app_todolist_desktop/features/todolist/data/repositories/todolist_repository_impl.dart';
import 'package:app_todolist_desktop/features/todolist/domain/repositories/todolist_repository.dart';
import 'package:app_todolist_desktop/features/todolist/domain/usecases/job_usecases.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
void initializeDependencies() {
  //registerLazySingleton: chỉ khởi tạo 1 lần và giữ lại instance
  //registerSingleton: khởi tạo mỗi lần gọi
  sl.registerLazySingleton<TodolistLocalDataSource>(
      () => TodolistLocalDataSourceImpl());
  sl.registerLazySingleton<TodolistRepository>(
      () => TodolistRepositoryImpl(sl<TodolistLocalDataSource>()));
  sl.registerLazySingleton(() => AddJobUsecase(sl<TodolistRepository>()));
  sl.registerLazySingleton(() => GetJobsUsecase(sl<TodolistRepository>()));
  sl.registerLazySingleton(
      () => DeleteJobByIdUsecase(sl<TodolistRepository>()));
  sl.registerLazySingleton(
      () => UpdateJobByIdUsecase(sl<TodolistRepository>()));
}
