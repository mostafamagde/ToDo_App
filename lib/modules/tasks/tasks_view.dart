import 'package:flutter/material.dart';
import 'package:calendar_slider/calendar_slider.dart';
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
          padding: EdgeInsets.only(bottom: 60),
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
                  style: theme.textTheme.bodyLarge ,
                ),
              ),
              Positioned(
                top: 90,
                child: CalendarSlider(
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(Duration(days: 50000)),
                  lastDate: DateTime.now().add(Duration(days: 40000)),
                  onDateSelected: (date) {
                    print(date);
                    setState(() {});
                  },
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
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) => TaskItem(),
            itemCount: 20,
          ),
        )
      ],
    );
  }
}
