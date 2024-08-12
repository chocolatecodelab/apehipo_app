import 'colors.dart';
import 'package:flutter/material.dart';

class SuccessConfirmationDialog extends StatefulWidget {
  final String message;
  final IconData icon;

  SuccessConfirmationDialog({required this.message, required this.icon});

  @override
  _SuccessConfirmationDialogState createState() =>
      _SuccessConfirmationDialogState();
}

class _SuccessConfirmationDialogState extends State<SuccessConfirmationDialog> {
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
              widget.icon,
              color: widget.icon == Icons.check_circle_outline
                  ? AppColors.primaryColor
                  : const Color.fromARGB(255, 182, 51, 42),
              size: 48,
            ),
            SizedBox(height: 20),
            Text(
              'Informasi',
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
                  onPressed: () {
                    Navigator.of(context).pop(false);
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
