import 'package:Apehipo/widgets/colors.dart';
import 'package:Apehipo/widgets/theme.dart';
import 'package:flutter/material.dart';

class SkeletonLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450, // Sesuaikan tinggi dengan konten yang akan dimuat
      color:
          Colors.grey[300], // Warna latar belakang yang menyerupai placeholder
      // Atur bentuk atau konten sesuai kebutuhan, seperti teks atau gambar
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/logo_primary.png', // Ganti dengan path gambar placeholder Anda
              width: 60, // Sesuaikan lebar gambar
              height: 60, // Sesuaikan tinggi gambar
              fit: BoxFit.contain, // Sesuaikan metode scaling gambar
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              "Mohon Tunggu",
              style: TextStyle(
                  color: AppColors.darkGrey,
                  fontFamily: poppinsFontFamily,
                  fontSize: 18),
            ),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          // Center(
          //     child: CircularProgressIndicator(
          //   color: AppColors.darkGrey,
          // ))
        ],
      ),
    );
  }
}
