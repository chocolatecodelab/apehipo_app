import 'package:flutter/material.dart';
import '../semai/screen/semai_screen.dart';
import '../tanam/screen/tanam_screen.dart';
import '../report/screen/report_screen.dart';

class NavigatorItem {
  final String label;
  final String iconPath;
  final int index;
  final Widget screen;

  NavigatorItem(this.label, this.iconPath, this.index, this.screen);
}

List<NavigatorItem> navigatorItemsKebun = [
  NavigatorItem("Semai", "assets/icons/semai-icon.svg", 0, SemaiScreen()),
  NavigatorItem(
    "Tanam",
    "assets/icons/tanam-icon.svg",
    1,
    TanamScreen(),
  ),
  NavigatorItem("Report", "assets/icons/report-icon.svg", 2, ReportScreen()),
];
