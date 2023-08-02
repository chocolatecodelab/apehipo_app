import 'package:apehipo_app/modules/cards/card_screen.dart';
import 'package:apehipo_app/modules/dashboard/dashboard_screen.dart';
import 'package:apehipo_app/modules/home/home_screen.dart';
import 'package:apehipo_app/modules/product/product_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:apehipo_app/widgets/theme.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: themeData,
      home: DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
