import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled/modules/models/task_model.dart';

import '../../core/app_provider.dart';
import '../../core/firebase_utiles.dart';

class TaskBottomSheet extends StatefulWidget {
  const TaskBottomSheet({super.key});

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
    var provider = Provider.of<SettingProuider>(context);
    return Container(
      padding: const EdgeInsets.only(
        right: 20,
        bottom: 16,
        top: 20,
        left: 20,
      ),
      color: provider.isDark()?Color(0xFF141922):Colors.white ,
      child: Form(
        key: formker,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add new Task",
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              cursorColor: provider.isDark()?Colors.grey:theme.primaryColor,

              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Task description is required";
                }
                return null;
              },
              controller: titlecontroler,
              style: theme.textTheme.bodyMedium,
              decoration:  InputDecoration(
                hintText: "Add new Task title",
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(color: provider.isDark()?Colors.grey:Colors.black),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color:  provider.isDark()?Colors.grey :theme.primaryColor,
                          width: 3
                      )
                  )
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              cursorColor: provider.isDark()?Colors.grey:theme.primaryColor,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Task title is required";
                }
                return null;
              },
              controller: desccontroler,
              style: theme.textTheme.bodyMedium,
              decoration:  InputDecoration(
                hintStyle: theme.textTheme.bodyMedium?.copyWith(color: provider.isDark()?Colors.grey:Colors.black),
                hintText: "Add Task Description",
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color:  provider.isDark()?Colors.grey :theme.primaryColor,
                          width: 3
                      )
                  )

              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Text("Select Date", style: theme.textTheme.bodyMedium),
            InkWell(
              child: Text(
                DateFormat("dd MMM yyyy").format(selecteddate),
                textAlign: TextAlign.center,
              ),
              onTap: () => showdate(),
            ),
            const Spacer(),
            FilledButton(
              onPressed: () {
                if (formker.currentState!.validate()) {
                  var task = TaskModel(
                    title: titlecontroler.text,
                    description: desccontroler.text,
                    selectedDate: selecteddate,
                  );
                  EasyLoading.show();
                  FirebaseUtiles.addTask(task).then((_) {
                    Navigator.pop(context);
                    EasyLoading.dismiss();
                    BotToast.showText(
                      text: "Added Successfully",

                      textStyle: theme.textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ); //popup a text toast;

                    //close
                  });
                }
              },
              style: FilledButton.styleFrom(
                backgroundColor: theme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Save",
                style:
                    theme.textTheme.bodyMedium?.copyWith(color:provider.isDark()?Color(0xFF060E1E): Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  showdate() async {
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
}
