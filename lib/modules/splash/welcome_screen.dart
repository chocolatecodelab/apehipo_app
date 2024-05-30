import 'package:Apehipo/modules/auth/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:Apehipo/widgets/app_button.dart';
import 'package:Apehipo/widgets/app_text.dart';
import 'package:Apehipo/widgets/colors.dart';

class WelcomeScreen extends StatelessWidget {
  final String imagePath = "./assets/images/IMG_20230813_155148.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Spacer(),
                icon(),
                SizedBox(
                  height: 20,
                ),
                welcomeTextWidget(),
                SizedBox(
                  height: 10,
                ),
                sloganText(),
                SizedBox(
                  height: 40,
                ),
                getButton(context),
                SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ));
  }

  Widget icon() {
    String iconPath = "assets/images/logo_white.png";
    return Image.asset(
      iconPath,
      width: 120,
      height: 120,
    );
  }

  Widget welcomeTextWidget() {
    return Column(
      children: [
        AppText(
          text: "Welcome to",
          fontSize: 48,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        AppText(
          text: "APEHIPO",
          fontSize: 48,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget sloganText() {
    return AppText(
      text:
          "Inspiring Growth: Apehipo, Your Hydroponic Farmers' Gateway to Market Expansion!",
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Color(0xffFCFCFC).withOpacity(0.7),
    );
  }

  Widget getButton(BuildContext context) {
    return AppButton(
      label: "Get Started",
      fontWeight: FontWeight.w600,
      padding: EdgeInsets.symmetric(vertical: 25),
      onPressed: () {
        onGetStartedClicked(context);
      },
    );
  }

  void onGetStartedClicked(BuildContext context) {
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
      builder: (BuildContext context) {
        return LoginScreen();
      },
    ));
  }
}
