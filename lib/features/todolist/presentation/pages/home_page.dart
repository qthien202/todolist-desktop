import 'package:app_todolist_desktop/features/todolist/domain/entities/job_entity.dart';
import 'package:app_todolist_desktop/features/todolist/presentation/bloc/job_bloc.dart';
import 'package:app_todolist_desktop/features/todolist/presentation/bloc/job_state.dart';
import 'package:app_todolist_desktop/features/todolist/presentation/pages/add_job_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    print(">>>>>>>screenWidth: $screenWidth");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Ứng dụng TodoList"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blue),
                ),
                onPressed: () async => await showAddJobDialog(context: context),
                child: Text(
                  "Thêm công việc",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ],
      ),
      body: BlocBuilder<JobBloc, JobState>(
        builder: (context, state) {
          if (state is JobLoading) {
            return CircularProgressIndicator();
          }

          if (state is JobIsEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Không có công việc nào",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            );
          }
          List<JobEntity> todoJobs =
              state is JobMultiStatusSuccess ? state.todoJobs : [];
          List<JobEntity> inProgressJobs =
              state is JobMultiStatusSuccess ? state.inProgressJobs : [];
          List<JobEntity> doneJobs =
              state is JobMultiStatusSuccess ? state.doneJobs : [];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
            child: SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  jobDragAndDrop(context, JobStatus.todo, todoJobs),
                  jobDragAndDrop(context, JobStatus.inProgress, inProgressJobs),
                  jobDragAndDrop(context, JobStatus.done, doneJobs),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
