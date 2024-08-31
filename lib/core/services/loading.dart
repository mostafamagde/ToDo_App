import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../AppThemeManager.dart';



configure() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..backgroundColor = Colors.white
    ..indicatorColor = Appthememanager.primaryligthhtcolor
    ..textColor = Colors.white
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = false
    ..dismissOnTap = false;
  //  ..customAnimation = CustomAnimation();
}
