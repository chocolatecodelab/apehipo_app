
import 'package:apehipo_app/modules/cart/cart_screen.dart';
import 'package:apehipo_app/modules/account/ImagePickerWidget.dart';
import 'package:apehipo_app/modules/account/account_katalog.dart';
import 'package:apehipo_app/modules/account/account_screen.dart';
import 'package:apehipo_app/modules/account/catalog_details.dart';
import 'package:apehipo_app/modules/dashboard/dashboard_screen.dart';
import 'package:apehipo_app/modules/order/order_screen.dart';
import 'package:apehipo_app/modules/order/order_screen_petani.dart';
import 'package:apehipo_app/modules/payment/payment_screen.dart';
import 'package:apehipo_app/modules/product/product_list.dart';
import 'package:apehipo_app/splash/welcome_screen.dart';

import 'package:flutter/material.dart';
import 'package:apehipo_app/splash/splash_screen.dart';
import 'package:apehipo_app/widgets/theme.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: themeData,
      home: PesananPetaniScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
