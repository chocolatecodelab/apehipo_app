import 'package:Apehipo/widgets/colors.dart';
import 'package:Apehipo/widgets/success_confirmation_dialog.dart';
import 'package:flutter/material.dart';

class ConfirmationDialogProses extends StatefulWidget {
  final String message;

  ConfirmationDialogProses({required this.message});

  @override
  _ConfirmationDialogProsesState createState() =>
      _ConfirmationDialogProsesState();
}

class _ConfirmationDialogProsesState extends State<ConfirmationDialogProses> {
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
                    bool? confirmationResult = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SuccessConfirmationDialog(
                          message: "Anda telah membatalkan pesanan",
                          icon: Icons.check_circle_outline,
                        );
                      },
                    );
                    if (confirmationResult == true) {
                    } else {}
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
