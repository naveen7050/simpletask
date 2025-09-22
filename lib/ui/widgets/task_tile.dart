import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simpletasks/models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;
  final Widget? leading;

  const TaskTile({super.key, required this.task, this.onTap, this.leading});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Text(task.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(DateFormat.yMMMd().add_jm().format(task.createdAt)),
      onTap: onTap,
    );
  }
}
