import 'package:flutter/material.dart';

class DynamicButtonWidget extends StatelessWidget {
  final String label;
  final Color textColor;
  final Color backgroundColor;
  final IconData? iconData;
  final VoidCallback onPressed;

  const DynamicButtonWidget({
    required this.label,
    required this.textColor,
    required this.backgroundColor,
    this.iconData,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 0,
          backgroundColor: backgroundColor,
          textStyle: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.w300,
            fontFamily: 'Gilroy',
          ),
          padding: EdgeInsets.symmetric(vertical: 24),
          minimumSize: const Size.fromHeight(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(color: textColor),
            ),
            SizedBox(width: 8),
            Icon(
              iconData,
              size: 18,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }
}
