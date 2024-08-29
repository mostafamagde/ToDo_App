import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:untitled/core/firebase_utiles.dart';
import 'package:untitled/modules/models/task_model.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xFFFE4A49),
      ),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: .3,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              onPressed: (BuildContext context) {
                FirebaseUtiles.deletetask(task);
                BotToast.showText(
                  text: "Deleted successfully",
                  textStyle:
                      theme.textTheme.bodyMedium!.copyWith(color: Colors.white),
                );
              },
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              autoClose: true,
            ),
          ],
        ),
        child: Container(
          // margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
            leading: VerticalDivider(
              color: task.isDone ? const Color(0xFF61E757) : theme.primaryColor,
              thickness: 5,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                      color:
                          task.isDone ? const Color(0xFF61E757) : theme.primaryColor),
                ),
                Text(
                  task.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: task.isDone ? const Color(0xFF61E757) : theme.primaryColor,
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
            trailing: InkWell(
              onTap: () {
                FirebaseUtiles.updatetask(task);
                BotToast.showText(
                  text: task.isDone?"You can do it!":"Good Job!",
                  textStyle:
                      theme.textTheme.bodyMedium!.copyWith(color: Colors.white),
                );
              },
              child: task.isDone
                  ? Text(
                      "Done!  ",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF61E757),
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  : Container(
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
          ),
        ),
      ),
    );
  }
}
