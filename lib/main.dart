import 'package:app_todolist_desktop/core/dependency_injections.dart';
import 'package:app_todolist_desktop/features/todolist/domain/repositories/todolist_repository.dart';
import 'package:app_todolist_desktop/features/todolist/domain/usecases/delete_job_by_status_usecase.dart';
import 'package:app_todolist_desktop/features/todolist/presentation/bloc/job_bloc.dart';
import 'package:app_todolist_desktop/features/todolist/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:window_manager/window_manager.dart';
import 'features/todolist/domain/usecases/job_usecases.dart';
import 'features/todolist/presentation/bloc/job_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await windowManager.ensureInitialized();

  // Đặt kích thước cửa sổ tối thiểu
  // windowManager.setMinimumSize(const Size(880, 400));
  sqfliteFfiInit();
  initializeDependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final repository = sl<TodolistRepository>();
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => JobBloc(
                  getJobsUsecase: GetJobsUsecase(repository),
                  addJobUsecase: AddJobUsecase(repository),
                  deleteJobUsecase: DeleteJobByIdUsecase(repository),
                  updateJobUsecase: UpdateJobByIdUsecase(repository),
                  getJobByStatusUseCase: GetJobByStatusUseCase(repository),
                  deleteJobByStatusUseCase:
                      DeleteJobByStatusUseCase(repository))
                ..add(GetJobByMultipleStatusEvent())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter TodoList Desktop',
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              appBarTheme: AppBarTheme(
                scrolledUnderElevation: 0.0,
              )),
          home: const HomePage(),
        ));
  }
}
