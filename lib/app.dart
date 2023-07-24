
import 'package:apehipo_app/modules/cart/cart_screen.dart';
import 'package:apehipo_app/modules/account/ImagePickerWidget.dart';
import 'package:apehipo_app/modules/account/account_katalog.dart';
import 'package:apehipo_app/modules/account/account_screen.dart';
import 'package:apehipo_app/modules/account/catalog_details.dart';
import 'package:apehipo_app/modules/product/product_list.dart';
import 'package:apehipo_app/splash/welcome_screen.dart';

import 'package:flutter/material.dart';
import 'package:apehipo_app/splash/splash_screen.dart';
import 'package:apehipo_app/widgets/theme.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
