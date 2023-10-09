import 'package:flutter/material.dart';
import 'package:apehipo_app/widgets/colors.dart';

String gilroyFontFamily = "Gilroy";
String montserratFontFamily = "Montserrat";
String poppinsFontFamily = "poppins";

ThemeData themeData = ThemeData(
  fontFamily: poppinsFontFamily,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme:
      ColorScheme.fromSwatch().copyWith(secondary: AppColors.primaryColor),
);
