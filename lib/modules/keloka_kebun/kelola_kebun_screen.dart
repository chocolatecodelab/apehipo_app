import 'package:Apehipo/modules/notification/screen/notification_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'model/navigator_item_model.dart';
import 'package:Apehipo/widgets/colors.dart';
import 'package:flutter/material.dart';

class KelolaKebunScreen extends StatefulWidget {
  @override
  State<KelolaKebunScreen> createState() => _KelolaKebunScreenState();
}

class _KelolaKebunScreenState extends State<KelolaKebunScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kelola Kebun",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        toolbarHeight: 80,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => NotificationScreen());
            },
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          )
        ],
      ),
      backgroundColor: AppColors.primaryColor,
      body: navigatorItemsKebun[currentIndex].screen,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black38.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 37,
                offset: Offset(0, -12)),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color(0xFF53B175),
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
            unselectedItemColor: Colors.black,
            items: navigatorItemsKebun.map((e) {
              return getNavigationBarItem(
                  label: e.label, iconPath: e.iconPath, index: e.index);
            }).toList(),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem getNavigationBarItem(
      {required label, required String iconPath, required int index}) {
    Color iconColor =
        index == currentIndex ? AppColors.primaryColor : Colors.black;
    return BottomNavigationBarItem(
        label: label,
        icon: SvgPicture.asset(
          iconPath,
          height: 25,
          color: iconColor,
        ));
  }
}
