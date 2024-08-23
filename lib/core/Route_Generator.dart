import 'package:flutter/material.dart';
import 'package:untitled/core/page_routes_names.dart';
import 'package:untitled/modules/layout_view/layout_view.dart';
import 'package:untitled/modules/login/login.dart';
import 'package:untitled/modules/splash/splash.dart';

import '../modules/regestration/regestration.dart';

class RouteGenerator {
  static Route<dynamic> GenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case PageRoutesNames.splash:
        return MaterialPageRoute(
          builder: (context) => const Splash(),
          settings: settings,
        );

      case PageRoutesNames.login:
        return MaterialPageRoute(
          builder: (context) => const Loginview(),
          settings: settings,
        );
      case PageRoutesNames.regester:
        return MaterialPageRoute(
          builder: (context) => const Regestration(),
          settings: settings,
        );
      case PageRoutesNames.layout:
        return MaterialPageRoute(
          builder: (context) => const LayoutView(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const Splash(),
          settings: settings,
        );
    }
  }
}
