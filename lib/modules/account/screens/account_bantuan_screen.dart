import 'package:Apehipo/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountBantuanScreen extends StatelessWidget {
  const AccountBantuanScreen({super.key});

  Future<void> _launchWhatsApp(String phoneNumber) async {
    final url =
        'https://wa.me/$phoneNumber'; // Ganti phoneNumber dengan nomor WhatsApp tujuan

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka WhatsApp';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bantuan',
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
      body: Container(
        color: const Color.fromARGB(255, 226, 226, 226),
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icons/flutter_icon.png'),
              SizedBox(
                height: 10,
              ),
              AppButton(
                label: "Hubungi Admin via WhatsApp",
                onPressed: () {
                  _launchWhatsApp(
                      '6285921357723'); // Ganti dengan nomor WhatsApp yang valid
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
