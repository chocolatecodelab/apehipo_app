import 'dart:async';

import 'package:Apehipo/modules/auth/controller/auth_controller.dart';
import 'package:Apehipo/modules/auth/screen/login_screen.dart';
import 'package:Apehipo/modules/bottom_bar_navigation/bottom_bar_navigation_screen.dart';
import 'package:Apehipo/modules/keloka_kebun/kelola_kebun_screen.dart';
import 'package:flutter/material.dart';
import 'package:Apehipo/widgets/app_text.dart';
import 'package:Apehipo/widgets/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    var auth = Get.put(AuthController());
    const delay = const Duration(seconds: 2);
    Future.delayed(delay, () => onTimerFinished(auth));
  }

  void onTimerFinished(AuthController auth) {
    if (auth.box.hasData("nama")) {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
        builder: (BuildContext context) {
          return BottomBarNavigationScreen();
        },
      ));
    } else {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
        builder: (BuildContext context) {
          return LoginScreen();
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon(),
            SizedBox(height: 10),
            AppText(
              text: "APEHIPO",
              fontSize: 48,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

Widget splashScreenIcon() {
  String iconPath = "assets/icons/shop_icon.svg";
  return SvgPicture.asset(
    iconPath,
  );
}

// Widget padded(Widget widget) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 25),
//       child: widget,
//     );
//   }

Widget icon() {
  String iconPath = "assets/images/logo_white.png";
  return Image.asset(
    iconPath,
    width: 120,
    height: 120,
  );
}
