import 'package:app_todolist_desktop/core/app_colors.dart';
import 'package:app_todolist_desktop/features/todolist/domain/entities/job_entity.dart';
import 'package:app_todolist_desktop/features/todolist/presentation/pages/add_job_dialog.dart';
import 'package:app_todolist_desktop/features/todolist/presentation/widgets/confirm_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/job_bloc.dart';
import '../bloc/job_event.dart';

Widget jobStatusWidget(
    {required Widget child,
    required String status,
    required BuildContext context,
    required List<JobEntity> jobs}) {
  Map<String, Color> badgeColor = {
    'todo': AppColors.todoBadge,
    'inProgress': AppColors.inProgressBadge,
    'done': AppColors.doneBadge
  };
  Map<String, dynamic> statusTextMap = {
    'todo': 'Chưa thực hiện',
    'inProgress': 'Đang thực hiện',
    'done': 'Hoàn thành'
  };

  return Visibility(
    visible: jobs.isNotEmpty,
    replacement: Container(
      height: MediaQuery.of(context).size.height * .5,
      width: MediaQuery.of(context).size.width * .2,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: jobs.isEmpty ? Colors.transparent : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                color: badgeColor[status],
                borderRadius: BorderRadius.circular(20)),
            child: Text(
              statusTextMap[status],
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          child
        ],
      ),
    ),
    child: Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: jobs.isEmpty ? Colors.transparent : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                color: badgeColor[status],
                borderRadius: BorderRadius.circular(20)),
            child: Text(
              statusTextMap[status],
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          child
        ],
      ),
    ),
  );
}

Future<void> showModalJob({
  required JobEntity job,
  required BuildContext context,
}) async {
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) {
      return CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.pop(context);
                await showAddJobDialog(
                    context: context, isEdit: true, job: job);
              },
              child: const Text(
                'Chỉnh sửa',
                style: TextStyle(fontSize: 16, color: Colors.black),
              )),
          Visibility(
            // visible: currentUser,
            child: CupertinoActionSheetAction(
                isDestructiveAction: true,
                onPressed: () async {
                  Navigator.pop(context);
                  await showCupertinoDialog(
                    context: context,
                    builder: (context) => confirmDialog(
                      context,
                      onDelete: () {
                        context
                            .read<JobBloc>()
                            .add(DeleteJobByIdEvent(id: job.id ?? 0));
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
                child: const Text(
                  'Xóa',
                  style: TextStyle(fontSize: 16),
                )),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            child: const Text(
              'Hủy',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            onPressed: () => Navigator.pop(context)),
      );
    },
  );
}
