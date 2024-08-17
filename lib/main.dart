import 'package:flutter/material.dart';

import 'core/AppThemeManager.dart';
import 'core/Route_Generator.dart';
import 'core/page_routes_names.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: PageRoutesNames.splash,
      onGenerateRoute: RouteGenerator.GenerateRoutes,
      theme: Appthememanager.lighttheme,

    );
  }
}

