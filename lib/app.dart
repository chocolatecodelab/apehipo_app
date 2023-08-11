import 'package:apehipo_app/modules/account/account_screen.dart';
import 'package:apehipo_app/modules/catalog/catalog_tambah.dart';
import 'package:apehipo_app/modules/catalog/katalog_screen.dart';
import 'package:apehipo_app/splash/welcome_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:apehipo_app/widgets/theme.dart';
import 'package:get/get.dart';

import 'modules/order/order_screen_petani.dart';

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
