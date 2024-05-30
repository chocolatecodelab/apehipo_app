import 'package:Apehipo/widgets/colors.dart';
import 'package:Apehipo/widgets/theme.dart';
import 'package:flutter/material.dart';

class PopUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        elevation: 5, // Tingkat kejelasan bayangan
        child: Container(
          padding: EdgeInsets.all(20), // Padding untuk konten dalam container
          width: 150, // Sesuaikan lebar container
          height: 150,
          color: Colors
              .transparent, // Warna latar belakang yang menyerupai placeholder
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Agar container menyesuaikan dengan konten
            children: [
              SizedBox(
                height: 20,
              ),
              CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Mohon Tunggu",
                style: TextStyle(
                  color: AppColors.darkGrey,
                  fontFamily: poppinsFontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              // CircularProgressIndicator(
              //   color: AppColors.darkGrey,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
