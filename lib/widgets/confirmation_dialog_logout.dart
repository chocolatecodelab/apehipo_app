import 'package:Apehipo/auth/auth_controller.dart';
import 'package:Apehipo/auth/login/login.dart';
import 'package:Apehipo/modules/cart/cart_change.dart';
import 'package:Apehipo/widgets/colors.dart';
import 'package:Apehipo/widgets/logout_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmationDialogLogout extends StatefulWidget {
  final String message;

  ConfirmationDialogLogout({required this.message});

  @override
  _ConfirmationDialogLogoutState createState() =>
      _ConfirmationDialogLogoutState();
}

class _ConfirmationDialogLogoutState extends State<ConfirmationDialogLogout> {
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
              Icons.warning,
              color: Colors.yellow,
              size: 48,
            ),
            SizedBox(height: 20),
            Text(
              'Konfirmasi',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(widget.message),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(30, 45),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    backgroundColor: AppColors.darkGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Tidak',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pop(true);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(30, 45),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Ya'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
