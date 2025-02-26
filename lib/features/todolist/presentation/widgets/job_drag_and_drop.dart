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
      context.read<JobBloc>().add(UpdateJobEvent(
          id: job.id ?? 0,
          job: JobEntity(
              id: job.id ?? 0,
              name: job.name,
              priority: job.priority,
              status: status.name)));
    },
    builder: (context, candidateData, rejectedData) {
      return jobStatusWidget(
        jobs: jobs,
        context: context,
        status: status.name,
        child: Column(
          children: jobs.map((job) {
            return Draggable(
                data: job,
                feedback: Opacity(opacity: 0.5, child: jobWidget(job, context)),
                child: jobWidget(job, context));
          }).toList(),
        ),
      );
    },
  );
}
