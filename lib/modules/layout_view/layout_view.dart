import 'package:flutter/material.dart';
import 'package:untitled/modules/setting/setting_view.dart';
import 'package:untitled/modules/tasks/tasks_view.dart';

import '../tasks/task_bottom_sheet.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int index = 0;
  List<Widget> screens = [
    const TasksView(),
    const SettingView(),
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Scaffold(
      extendBody: true,
      backgroundColor: Color(0xffDFECDB),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => TaskBottomSheet(),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        child: CircleAvatar(
          backgroundColor: theme.primaryColor,
          radius: 23,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 100,
        notchMargin: 10,
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          onTap: (value) {
            index = value;
            setState(() {});
          },
          currentIndex: index,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedLabelStyle: TextStyle(),
          items: [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/icons/Icon awesome-list.png"),
              ),
              label: "Tasks",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/icons/Path 7.png"),
              ),
              label: "Settings",
            ),
          ],
        ),
      ),
      body: screens[index],
    );
  }
}
