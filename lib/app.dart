import 'package:Apehipo/modules/splash/splash_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:Apehipo/widgets/theme.dart';


class MyApp extends StatelessWidget {
  MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: gilroyFontFamily),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
