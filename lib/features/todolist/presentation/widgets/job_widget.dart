import 'package:app_todolist_desktop/features/todolist/domain/entities/job_entity.dart';
import 'package:flutter/material.dart';

Widget jobWidget(JobEntity job) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade200),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Text(
          job.name,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(job.isDone ? 'Done' : 'Not done'),
        Text(job.priority.toString()),
      ],
    ),
  );
}
