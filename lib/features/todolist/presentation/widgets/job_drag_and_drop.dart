import 'package:app_todolist_desktop/features/todolist/domain/entities/job_entity.dart';
import 'package:app_todolist_desktop/features/todolist/presentation/bloc/job_bloc.dart';
import 'package:app_todolist_desktop/features/todolist/presentation/bloc/job_event.dart';
import 'package:app_todolist_desktop/features/todolist/presentation/widgets/job_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'job_status_widget.dart';

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
