import 'package:apehipo_app/auth/login/login.dart';
import 'package:apehipo_app/splash/welcome_screen.dart';
import 'package:apehipo_app/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArsipConfirmationDialog extends StatefulWidget {
  final String message;

  ArsipConfirmationDialog({required this.message});

  @override
  _ArsipConfirmationDialogState createState() =>
      _ArsipConfirmationDialogState();
}

class _ArsipConfirmationDialogState extends State<ArsipConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: AppColors.primaryColor,
              size: 48,
            ),
            SizedBox(height: 20),
            Text(
              'Sukses',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(widget.message),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => {
                    Get.back(),
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 50),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Ok',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
