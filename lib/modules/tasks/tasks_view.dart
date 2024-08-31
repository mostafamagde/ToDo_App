import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:calendar_slider/calendar_slider.dart';
import 'package:provider/provider.dart';
import 'package:untitled/core/firebase_utiles.dart';
import 'package:untitled/modules/models/task_model.dart';
import 'package:untitled/modules/tasks/task_item.dart';

import '../../core/app_provider.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  var controler = CalendarSliderController();
  var currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var provider =Provider.of<SettingProuider>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: media.width,
                height: media.height * .22,
                color:theme.primaryColor,
                child: Text(
                  "   To Do List",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: provider.isDark()? Color(0xFF060E1E) : Colors.white
                  ),
                ),
              ),
              Positioned(
                top: 90,
                child: CalendarSlider(
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(
                    const Duration(days: 50000),
                  ),
                  lastDate: DateTime.now().add(
                    const Duration(days: 40000),
                  ),
                  onDateSelected: (date) {
                    currentDate = date;
                    setState(() {});
                  },
                  selectedDayPosition: SelectedDayPosition.center,
                  selectedTileHeight: 170,
                  controller: controler,
                  fullCalendar: true,
                  calendarEventSelectedColor: Colors.white,
                  fullCalendarScroll: FullCalendarScroll.vertical,
                  selectedTileBackgroundColor: provider.isDark()? Colors.white :theme.primaryColor,
                 tileBackgroundColor: !provider.isDark()? Colors.white:Color(0xFF141922),
                  calendarEventColor:  provider.isDark()?Color(0xFF141922) :theme.primaryColor,
                  dateColor:  provider.isDark()? Colors.white :Colors.black,


                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<TaskModel>>(
            stream: FirebaseUtiles.getStream(currentDate),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
               return Center(
                 child: SizedBox(
                   width: 40,
                     height: 40,
                   child: CircularProgressIndicator(
                     color: theme.primaryColor,
                     backgroundColor: Colors.transparent,
                   ),
                 ),
               );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Something went wrong"),
                );
              }
              List<TaskModel> taskslist = snapshot.data?.docs.map((toElement)=>toElement.data()).toList()??[];
              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 110),
                itemBuilder: (context, index) =>  TaskItem(task: taskslist[index],),
                itemCount: taskslist.length ,
              );
            },
          ),
        )
        /*  Expanded(
          child: FutureBuilder<List<TaskModel>>(
            future: FirebaseUtiles.getTasks(currentDate),
            builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                 EasyLoading.show();

              }
              if(snapshot.hasError){
                return const Center(child: Text("Something went wrong"),);
              }
              EasyLoading.dismiss();
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) =>  TaskItem(task: snapshot.data![index],),
                itemCount: snapshot.data?.length ??0,
              );

            },
          ),
        )*/
        /*
       *  Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) => const TaskItem(),
            itemCount: 20,
          ),
        )*/
      ],
    );
  }
}
