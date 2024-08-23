import 'package:flutter/material.dart';

class Appthememanager {
  static const Color primarycolor = Color(0xFF5D9CEC);
  static ThemeData lighttheme = ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
    primaryColor: primarycolor,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 25,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontFamily: "Poppins",
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: TextStyle(
        fontFamily: "Poppins",
        fontSize: 25,
        color: Colors.black,
        fontWeight: FontWeight.w700,
      ),
      bodySmall: TextStyle(
        fontFamily: "Poppins",
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      displayMedium: TextStyle(
        fontFamily: "Poppins",
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(
        color: primarycolor,
        size: 35,
      ),
      unselectedIconTheme: IconThemeData(
        size: 27,
      ),
      showSelectedLabels: false

    ),
  );
}
