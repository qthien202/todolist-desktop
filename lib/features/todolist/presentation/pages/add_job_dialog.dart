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
    required JobPriority selectedPriority,
    int? id}) {
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
                .map((status) => DropdownMenuItem(
                    value: status, child: Text(statusMapText[status.name])))
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
                    value: priority,
                    child: Text(priorityMapText[priority.name])))
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
            if (id != null) {
              final newJob = JobModel(
                  id: id,
                  name: nameController.text,
                  status: selectedStatus.name,
                  priority: selectedPriority.name);
              context.read<JobBloc>().add(UpdateJobEvent(job: newJob, id: id));
              Navigator.pop(context);
            } else {
              context.read<JobBloc>().add(AddJobEvent(
                  job: JobModel(
                      name: nameController.text,
                      status: selectedStatus.name,
                      priority: selectedPriority.name)));
              Navigator.pop(context);
            }
          }
        },
        child: Text("Lưu"),
      ),
    ],
  );
}

Map<String, dynamic> statusMapText = {
  'todo': 'Chưa thực hiện',
  'inProgress': 'Đang thực hiện',
  'pending': 'Tạm dừng',
  'done': 'Hoàn thành'
};

Map<String, dynamic> priorityMapText = {
  'low': 'Thấp',
  'medium': 'Bình thường',
  'high': 'Cao'
};

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
    JobEntity? job,
    bool isEdit = false}) async {
  final TextEditingController nameController = TextEditingController();
  nameController.text = job?.name ?? "";
  final selectedStatus =
      job?.status != null ? statusMap[job?.status] : JobStatus.todo;
  final selectedPriority =
      job?.priority != null ? priorityMap[job?.priority] : JobPriority.low;
  return await showDialog(
    context: context,
    builder: (context) {
      return addJobDialog(
          context: context,
          nameController: nameController,
          selectedStatus: selectedStatus,
          selectedPriority: selectedPriority,
          id: isEdit ? job?.id : null);
    },
  );
}
