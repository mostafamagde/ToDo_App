import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/core/app_provider.dart';

import '../../core/page_routes_names.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.pushReplacementNamed(context, PageRoutesNames.login);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<SettingProuider>(context);
    return Image.asset(
      provider.isDark()?"assets/images/splash – 1.png":
      "assets/images/splash_background.png",
      fit: BoxFit.cover,
    );
  }
}
