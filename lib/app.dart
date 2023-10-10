import 'package:Apehipo/splash/splash_screen.dart';
import 'package:Apehipo/splash/welcome_screen.dart';
import 'package:Apehipo/widgets/dropdown.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:Apehipo/widgets/theme.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: gilroyFontFamily),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
