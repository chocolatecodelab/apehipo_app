import 'package:Apehipo/widgets/colors.dart';
import 'package:flutter/material.dart';

class ButtonKelolaKebun extends StatelessWidget {
  final String textButton;
  final VoidCallback onTap;
  ButtonKelolaKebun({super.key, required this.textButton, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: double.infinity,
      margin: EdgeInsets.all(
        25,
      ),
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          textButton,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
      ),
    );
  }
}
