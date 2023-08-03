import 'package:apehipo_app/auth/login/login.dart';
import 'package:apehipo_app/modules/cards/card_screen.dart';
import 'package:apehipo_app/modules/cart/cart_screen.dart';
import 'package:apehipo_app/modules/dashboard/dashboard_screen.dart';
import 'package:apehipo_app/splash/splash_screen.dart';
import 'package:apehipo_app/splash/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:apehipo_app/widgets/theme.dart';
import 'package:get/get.dart';

import 'modules/order/order_screen_petani.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: themeData,
      home: CartScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
