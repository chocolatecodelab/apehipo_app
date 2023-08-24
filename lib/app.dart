import 'package:apehipo_app/splash/welcome_screen.dart';
import 'package:apehipo_app/widgets/dropdown.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:apehipo_app/widgets/theme.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: themeData,
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
