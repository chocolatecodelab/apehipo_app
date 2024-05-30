import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  //One instance, needs factory
  static AppColors? _instance;
  factory AppColors() => _instance ??= AppColors._();

  AppColors._();
  static const whiteGrey = Color.fromARGB(255, 240, 240, 240);
  static const primaryColor = Color(0xff53B175);
  static const darkGrey = Color(0xff7C7C7C);
}
