import 'package:app_todolist_desktop/core/dependency_injections.dart';
import 'package:app_todolist_desktop/features/todolist/domain/repositories/todolist_repository.dart';
import 'package:app_todolist_desktop/features/todolist/presentation/bloc/job_bloc.dart';
import 'package:app_todolist_desktop/features/todolist/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'features/todolist/domain/usecases/job_usecases.dart';
import 'features/todolist/presentation/bloc/job_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => JobBloc(
                    getJobsUsecase: GetJobsUsecase(sl<TodolistRepository>()),
                    addJobUsecase: AddJobUsecase(sl<TodolistRepository>()),
                    deleteJobUsecase:
                        DeleteJobByIdUsecase(sl<TodolistRepository>()),
                    updateJobUsecase:
                        UpdateJobByIdUsecase(sl<TodolistRepository>()),
                  )..add(GetJobsEvent())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter TodoList Desktop',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomePage(),
        ));
  }
}
