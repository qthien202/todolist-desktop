import 'package:app_todolist_desktop/core/dependency_injections.dart';
import 'package:app_todolist_desktop/features/todolist/data/data_sources/todolist_local_data_source.dart';
import 'package:app_todolist_desktop/features/todolist/data/data_sources/todolist_local_data_source_impl.dart';
import 'package:app_todolist_desktop/features/todolist/data/repositories/todolist_repository_impl.dart';
import 'package:app_todolist_desktop/features/todolist/domain/repositories/todolist_repository.dart';
import 'package:app_todolist_desktop/features/todolist/domain/usecases/add_job_usecase.dart';
import 'package:app_todolist_desktop/features/todolist/presentation/bloc/job_bloc.dart';
import 'package:app_todolist_desktop/features/todolist/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'features/todolist/domain/usecases/job_usecases.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
                  )),
        ],
        child: MaterialApp(
          title: 'Flutter TodoList Desktop',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomePage(),
        ));
  }
}
