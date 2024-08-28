import 'package:flutter/material.dart';
import 'package:calendar_slider/calendar_slider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:untitled/core/firebase_utiles.dart';
import 'package:untitled/modules/models/task_model.dart';
import 'package:untitled/modules/tasks/task_item.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  var controler = CalendarSliderController();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var theme = Theme.of(context);

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
                color: theme.primaryColor,
                child: Text(
                  "   To Do List",
                  style: theme.textTheme.bodyLarge,
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
                  onDateSelected: (date) {},
                  selectedDayPosition: SelectedDayPosition.center,
                  selectedTileHeight: 170,
                  controller: controler,
                  fullCalendar: true,
                  calendarEventSelectedColor: Colors.black,
                  fullCalendarScroll: FullCalendarScroll.vertical,
                  selectedTileBackgroundColor: theme.primaryColor,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<TaskModel>>(
            future: FirebaseUtiles.getTasks(),
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
        )
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
