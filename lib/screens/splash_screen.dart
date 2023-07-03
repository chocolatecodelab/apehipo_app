import 'dart:async';

import 'package:flutter/material.dart';
import 'package:apehipo_app/screens/welcome_screen.dart';
import 'package:apehipo_app/common_widgets/app_text.dart';
import 'package:apehipo_app/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    const delay = const Duration(seconds: 3);
    Future.delayed(delay, () => onTimerFinished());
  }

  void onTimerFinished() {
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
      builder: (BuildContext context) {
        return WelcomeScreen();
      },
    ));
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
  String iconPath = "assets/icons/app_icon.svg";
  return SvgPicture.asset(
    iconPath,
    width: 48,
    height: 56,
  );
}
