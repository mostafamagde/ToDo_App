import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled/modules/models/task_model.dart';
import '../../core/app_provider.dart';
import '../../core/firebase_utiles.dart';

class TaskBottomSheet extends StatefulWidget {
  final bool edit;
  TaskModel? task;


  TaskBottomSheet({super.key, required this.edit, this.task});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  var selecteddate = DateTime.now();
  var titlecontroler = TextEditingController();
  var desccontroler = TextEditingController();
  var formker = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var media =MediaQuery .of(context).size;
    var provider = Provider.of<SettingProuider>(context);
    return Container(
      height:media.height*.55,
      padding: const EdgeInsets.only(
        right: 20,
        bottom: 16,
        top: 20,
        left: 20,
      ),
      color: provider.isDark() ? const Color(0xFF141922) : Colors.white,
      child: Form(
        key: formker,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             Text(
             widget.edit? "Edit Task":"Add new Task",
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              cursorColor: provider.isDark() ? Colors.grey : theme.primaryColor,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Task description is required";
                }
                return null;
              },
              controller: titlecontroler,
              style: theme.textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText:widget.edit?"Edit Task title": "Add new Task title",
                hintStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: provider.isDark() ? Colors.grey : Colors.black),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color:
                          provider.isDark() ? Colors.grey : theme.primaryColor,
                      width: 3),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              cursorColor: provider.isDark() ? Colors.grey : theme.primaryColor,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Task title is required";
                }
                return null;
              },
              controller: desccontroler,
              style: theme.textTheme.bodyMedium,
              decoration: InputDecoration(
                hintStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: provider.isDark() ? Colors.grey : Colors.black),
                hintText:widget.edit?"Edit Task Description": "Add Task Description",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color:
                          provider.isDark() ? Colors.grey : theme.primaryColor,
                      width: 3),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(widget.edit?"Edit Date":"Select Date", style: theme.textTheme.bodyMedium),
            InkWell(
              child: Text(
                DateFormat("dd MMM yyyy").format(selecteddate),
                textAlign: TextAlign.center,
              ),
              onTap: () async {
                {
                  var date = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(
                      const Duration(days: 365),
                    ),
                  );
                  if (date != null) {
                    setState(() {});
                    selecteddate = date;
                  }
                }
              },
            ),
             widget.edit?const SizedBox(height: 50,) :const Spacer(),
            FilledButton(
              onPressed: () {
                if (formker.currentState!.validate()) {
                  var id =  widget.task?.id;
                  widget.task = TaskModel(
                    title: titlecontroler.text,
                    description: desccontroler.text,
                    selectedDate: selecteddate,
                    id: id,
                  );

                  EasyLoading.show();
                  widget.edit
                      ? FirebaseUtiles.editTask(widget.task!).then(
                        (_) {
                      Navigator.pop(context);
                      EasyLoading.dismiss();
                      BotToast.showText(
                        text: "Edited Successfully",
                        textStyle: theme.textTheme.bodySmall!.copyWith(
                          color: Colors.white,
                        ),
                      ); //popup a text toast;

                      //close
                    },
                  )
                      : FirebaseUtiles.addTask(widget.task!).then(
                        (_) {
                      Navigator.pop(context);
                      EasyLoading.dismiss();
                      BotToast.showText(
                        text: "Added Successfully",
                        textStyle: theme.textTheme.bodySmall!.copyWith(
                          color: Colors.white,
                        ),
                      ); //popup a text toast;

                      //close
                    },
                  );
                }
              },
              style: FilledButton.styleFrom(
                backgroundColor: theme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                widget.edit?"Edit": "Save",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: provider.isDark() ? const Color(0xFF060E1E) : Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20,),
            widget.edit? FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: FilledButton.styleFrom(
                backgroundColor: theme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
               "Cancel",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: provider.isDark() ? const Color(0xFF060E1E) : Colors.white,
                ),
              ),
            ):Container(),


          ],
        ),
      ),
    );
  }
}
