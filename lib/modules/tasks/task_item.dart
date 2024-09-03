import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled/core/app_provider.dart';
import 'package:untitled/core/firebase_utiles.dart';
import 'package:untitled/modules/models/task_model.dart';
import 'package:untitled/modules/tasks/task_bottom_sheet.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({super.key, required this.task});

  final TaskModel task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    var provider = Provider.of<SettingProuider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: theme.primaryColor),
        child: Slidable(
          startActionPane: ActionPane(
            extentRatio: .3,
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                onPressed: (BuildContext context) {
                  FirebaseUtiles.deleteTask(widget.task);
                  BotToast.showText(
                    text: "Deleted successfully",
                    textStyle: theme.textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
                  );
                },
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
              ),
              SlidableAction(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                onPressed: (BuildContext context) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                       AlertDialog(
                        backgroundColor: Colors.white,
                        content: TaskBottomSheet(edit: true,task:widget. task,),

                      )

                  );

                },
              ),
            ],
          ),
          child: Container(
            // margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: provider.isDark() ? Color(0xFF141922) : Colors.white,
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
              leading: VerticalDivider(
                color:
                    widget.task.isDone ? const Color(0xFF61E757) : theme.primaryColor,
                thickness: 5,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.task.title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                        color: widget.task.isDone
                            ? const Color(0xFF61E757)
                            : theme.primaryColor),
                  ),
                  Text(
                    widget.task.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: widget.task.isDone
                          ? const Color(0xFF61E757)
                          : theme.primaryColor,
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
                      Text(
                        DateFormat("dd MMM yyyy").format(widget.task.selectedDate),
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: theme.primaryColor),
                      ),
                    ],
                  )
                ],
              ),
              trailing: InkWell(
                onTap: () {
                  FirebaseUtiles.isDone(widget.task);
                  BotToast.showText(
                    text: widget.task.isDone ? "You can do it!" : "Good Job!",
                    textStyle: theme.textTheme.bodyMedium!
                        .copyWith(color: Colors.white),
                  );
                },
                child: widget.task.isDone
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
      ),
    );
  }
}
