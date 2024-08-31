import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'core/app_provider.dart';
import 'core/services/loading.dart';
import 'firebase_options.dart';
import 'core/AppThemeManager.dart';
import 'core/Route_Generator.dart';
import 'core/page_routes_names.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:bot_toast/bot_toast.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => SettingProuider(),
      child: MyApp(),
    ),
  );
  configure();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingProuider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: PageRoutesNames.splash,
      onGenerateRoute: RouteGenerator.GenerateRoutes,
      theme: Appthememanager.lighttheme,
      builder: EasyLoading.init(
        builder: BotToastInit(),
      ),
      themeMode: provider.currenttheme,
      darkTheme: Appthememanager.darktheme,
    );
  }
}
