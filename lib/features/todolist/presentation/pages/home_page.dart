import 'package:app_todolist_desktop/features/todolist/domain/entities/job_entity.dart';
import 'package:app_todolist_desktop/features/todolist/presentation/bloc/job_bloc.dart';
import 'package:app_todolist_desktop/features/todolist/presentation/bloc/job_event.dart';
import 'package:app_todolist_desktop/features/todolist/presentation/bloc/job_state.dart';
import 'package:app_todolist_desktop/features/todolist/presentation/pages/add_job_dialog.dart';
import 'package:app_todolist_desktop/features/todolist/presentation/widgets/job_status_widget.dart';
import 'package:app_todolist_desktop/features/todolist/presentation/widgets/job_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          if (kDebugMode) {
            print(">>>>>>>>state2: $state");
          }

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

  Widget jobDragAndDrop(
      BuildContext context, JobStatus status, List<JobEntity> jobs) {
    return DragTarget<JobEntity>(
      onAcceptWithDetails: (details) {
        final job = details.data;
        print(">>>>>status: ${job.status}");
        context.read<JobBloc>().add(UpdateJobEvent(
            id: job.id ?? 0,
            job: JobEntity(
                id: job.id ?? 0,
                name: job.name,
                priority: job.priority,
                status: status.name)));
      },

      // onWillAcceptWithDetails: (details) {
      //   final job = details.data;
      //   context.read<JobBloc>().add(UpdateJobEvent(
      //       id: job.id ?? 0,
      //       job: JobEntity(
      //           id: job.id ?? 0,
      //           name: job.name,
      //           priority: job.priority,
      //           status: status.name)));
      //   return true;
      // },
      // onMove: (details) {
      //   final job = details.data;
      //   print(">>>>>status: ${job.status}");
      //   context.read<JobBloc>().add(UpdateJobEvent(
      //       id: job.id ?? 0,
      //       job: JobEntity(
      //           id: job.id ?? 0,
      //           name: job.name,
      //           priority: job.priority,
      //           status: status.name)));
      // },
      builder: (context, candidateData, rejectedData) {
        return jobStatusWidget(
          jobs: jobs,
          context: context,
          status: status.name,
          child: Column(
            children: jobs.map((job) {
              return Draggable(
                  // onDragUpdate: (details) {
                  //   final dx = details.globalPosition.dx;
                  //   final dy = details.globalPosition.dy;

                  //   if (dx < 300) {
                  //     // Ví dụ: nếu công việc kéo gần vùng "Chưa thực hiện"
                  //     print("Công việc đang gần vùng 'Chưa thực hiện'");
                  //     context.read<JobBloc>().add(UpdateJobEvent(
                  //         id: job.id ?? 0,
                  //         job: JobEntity(
                  //             id: job.id ?? 0,
                  //             name: job.name,
                  //             priority: job.priority,
                  //             status: JobStatus.todo.name)));
                  //   }
                  // },
                  data: job,
                  feedback: jobWidget(job, context),
                  child: jobWidget(job, context));
            }).toList(),
          ),
        );
      },
    );
  }
}
