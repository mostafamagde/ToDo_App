import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/core/app_provider.dart';
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
    var provider =Provider.of<SettingProuider>(context);

    return Scaffold(
      extendBody: true,
      backgroundColor: provider.isDark()?Color(0xFF060E1E): Color(0xffDFECDB),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => const TaskBottomSheet(),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80),
        ),
        child: CircleAvatar(
          backgroundColor:theme.primaryColor,
          radius: provider.isDark()?30: 23,
          child:  Icon(
            Icons.add,
            color:Colors.white,
            size: 30,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 100,
        notchMargin: 10,
        color:  provider.isDark()? Color(0xff141922) :Colors.white,
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          onTap: (value) {
            index = value;
            setState(() {});
          },
          currentIndex: index,
         // backgroundColor: Colors.transparent,
          elevation: 0,

          items: const [
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
