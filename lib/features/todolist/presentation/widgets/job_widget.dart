import 'package:app_todolist_desktop/features/todolist/domain/entities/job_entity.dart';
import 'package:app_todolist_desktop/features/todolist/presentation/pages/add_job_dialog.dart';
import 'package:flutter/material.dart';

Widget jobWidget(JobEntity job, BuildContext context) {
  Map<String, dynamic> statusMap = {
    'todo': 'Chưa thực hiện',
    'inProgress': 'Đang thực hiện',
    'pending': 'Tạm dừng',
    'done': 'Hoàn thành'
  };

  Map<String, dynamic> priorityMap = {
    'low': 'Thấp',
    'medium': 'Bình thường',
    'high': 'Cao'
  };
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade200),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                job.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              InkWell(
                  onTap: () => showAddJobDialog(
                      context: context, job: job, isEdit: true),
                  child: Icon(Icons.edit_outlined))
            ],
          ),
          Text(statusMap[job.status]),
          Text(priorityMap[job.priority]),
        ],
      ),
    ),
  );
}
