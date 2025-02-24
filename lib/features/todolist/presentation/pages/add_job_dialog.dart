import 'package:app_todolist_desktop/features/todolist/domain/entities/job_entity.dart';
import 'package:app_todolist_desktop/features/todolist/presentation/bloc/job_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/job.dart';
import '../bloc/job_bloc.dart';

Widget addJobDialog(
    {required BuildContext context,
    required TextEditingController nameController,
    required JobStatus selectedStatus,
    required JobPriority selectedPriority}) {
  return AlertDialog(
    title: Text("Thêm công việc"),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: nameController,
          decoration: InputDecoration(labelText: "Tên công việc"),
        ),
        SizedBox(height: 10),
        DropdownButtonFormField<JobStatus>(
          value: selectedStatus,
          decoration: InputDecoration(labelText: "Trạng thái"),
          items: JobStatus.values
              .map((status) =>
                  DropdownMenuItem(value: status, child: Text(status.name)))
              .toList(),
          onChanged: (value) {
            if (value != null) selectedStatus = value;
          },
        ),
        SizedBox(height: 10),
        DropdownButtonFormField<JobPriority>(
          value: selectedPriority,
          decoration: InputDecoration(labelText: "priority"),
          items: JobPriority.values
              .map((priority) =>
                  DropdownMenuItem(value: priority, child: Text(priority.name)))
              .toList(),
          onChanged: (value) {
            if (value != null) selectedPriority = value;
          },
        ),
      ],
    ),
    actions: [
      // Nút Hủy
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text("Hủy"),
      ),
      // Nút Lưu
      ElevatedButton(
        onPressed: () {
          context.read<JobBloc>().add(AddJobEvent(
              job: JobModel(
                  name: nameController.text,
                  status: selectedStatus.name,
                  priority: selectedPriority.name)));
          Navigator.pop(context);
        },
        child: Text("Lưu"),
      ),
    ],
  );
}

Future<void> showAddJobDialog({
  required BuildContext context,
}) async {
  final TextEditingController nameController = TextEditingController();
  final selectedStatus = JobStatus.todo;
  final selectedPriority = JobPriority.low;
  return await showDialog(
    context: context,
    builder: (context) {
      return addJobDialog(
        context: context,
        nameController: nameController,
        selectedStatus: selectedStatus,
        selectedPriority: selectedPriority,
      );
    },
  );
}
