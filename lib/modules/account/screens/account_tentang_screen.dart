import 'package:flutter/material.dart';

class AccountTentangScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tentang',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 0,
                  offset: Offset(0, 0), // Controls the position of the shadow
                ),
              ],
            ),
          ),
        ),
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 22, 22, 22),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Gambar logo atau ilustrasi tentang aplikasi Anda
            Image.asset('assets/icons/flutter_icon.png',
                width: 150, height: 150),

            SizedBox(height: 20),

            // Deskripsi tentang aplikasi Anda
            Text(
              'APEHIPO: Aplikasi Media Pemasaran Berbasis Mobile Sebagai Solusi Inovatif\n'
              'Untuk Memperluas Penjualan Hasil Kebun Hidroponik di Indonesia',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Versi aplikasi
            Text(
              'Versi Aplikasi: 1.0.0',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
