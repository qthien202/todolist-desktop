import 'package:app_todolist_desktop/core/app_colors.dart';
import 'package:app_todolist_desktop/features/todolist/domain/entities/job_entity.dart';
import 'package:app_todolist_desktop/features/todolist/presentation/pages/add_job_dialog.dart';
import 'package:flutter/material.dart';
import 'job_status_widget.dart';

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

  // ignore: unused_local_variable
  Map<String, Color> priorityColor = {
    'low': AppColors.low,
    'medium': AppColors.medium,
    'high': AppColors.high
  };

  return InkWell(
    onTap: () async =>
        await showAddJobDialog(context: context, isEdit: true, job: job),
    child: Container(
      width: MediaQuery.of(context).size.width * .2,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                job.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  InkWell(
                      onTap: () => showModalJob(
                            context: context,
                            job: job,
                          ),
                      child: Icon(Icons.more_horiz)),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              )
            ],
          ),
          // Text(statusMap[job.status]),
          const SizedBox(
            height: 20,
          ),
          Container(
              // alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: priorityColor[job.priority]),
              child: Text(
                "${priorityMap[job.priority]}",
                style: TextStyle(color: Colors.white, fontSize: 12),
              )),
        ],
      ),
    ),
  );
}
