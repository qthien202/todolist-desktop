import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget confirmDialog(BuildContext context, {void Function()? onDelete}) {
  return CupertinoAlertDialog(
    title: Text("Bạn có chắc muốn xóa công việc này không?"),
    actions: [
      CupertinoDialogAction(
        onPressed: () => Navigator.pop(context),
        child: Text(
          'Không',
          style: TextStyle(color: Colors.black),
        ),
      ),
      CupertinoDialogAction(
        isDestructiveAction: true,
        onPressed: onDelete,
        child: Text("Tiếp tục"),
      )
    ],
  );
}
