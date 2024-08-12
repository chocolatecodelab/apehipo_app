import '../../../widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarKelolaKebun extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;

  AppBarKelolaKebun({super.key, required this.title, this.height = 80});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 80,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
