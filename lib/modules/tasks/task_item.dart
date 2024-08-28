import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/modules/models/task_model.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
        leading: VerticalDivider(
          color: theme.primaryColor,
          thickness: 5,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.primaryColor),
            ),
            Text(
              task.description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.primaryColor,
                fontSize: 14,
              ),
            ),
            Row(
              children: [
                const Icon(
                  Icons.alarm,
                  size: 18,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(DateFormat("dd MMM yyyy").format(task.selectedDate),
                    style: theme.textTheme.bodySmall),
              ],
            )
          ],
        ),
        trailing: Container(
          margin: const EdgeInsets.only(right: 10),
          width: 70,
          height: 40,
          decoration: BoxDecoration(
            color: theme.primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.check,
            color: Colors.white,
            size: 35,
          ),
        ),
      ),
    );
  }
}
