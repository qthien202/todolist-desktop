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
  final formKey = GlobalKey<FormState>();
  return AlertDialog(
    title: Text("Thêm công việc"),
    content: Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            validator: (value) {
              String val = value ?? "";
              if (val.isEmpty) {
                return "Vui lòng nhập tên công việc";
              }
              if (val.length < 5) {
                return "Tên công việc bắt đầu từ 5 kí tự trở lên";
              }
              return null;
            },
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
                .map((priority) => DropdownMenuItem(
                    value: priority, child: Text(priority.name)))
                .toList(),
            onChanged: (value) {
              if (value != null) selectedPriority = value;
            },
          ),
        ],
      ),
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
          if (formKey.currentState?.validate() == true) {
            context.read<JobBloc>().add(AddJobEvent(
                job: JobModel(
                    name: nameController.text,
                    status: selectedStatus.name,
                    priority: selectedPriority.name)));
            Navigator.pop(context);
          }
        },
        child: Text("Lưu"),
      ),
    ],
  );
}

Map<String, dynamic> statusMap = {
  'todo': JobStatus.todo,
  'inProgress': JobStatus.inProgress,
  'pending': JobStatus.pending,
  'done': JobStatus.done
};

Map<String, dynamic> priorityMap = {
  'low': JobPriority.low,
  'medium': JobPriority.medium,
  'high': JobPriority.high
};
Future<void> showAddJobDialog(
    {required BuildContext context,
    String? name,
    String? status,
    String? priority}) async {
  final TextEditingController nameController = TextEditingController();
  nameController.text = name ?? "";
  final selectedStatus = status != null ? statusMap[status] : JobStatus.todo;
  final selectedPriority =
      priority != null ? priorityMap[priority] : JobPriority.low;
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
