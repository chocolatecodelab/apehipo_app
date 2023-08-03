import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:apehipo_app/widgets/app_button.dart';

class OrderAcceptedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(
              flex: 10,
            ),
            SvgPicture.asset("assets/icons/order_accepted_icon.svg"),
            Spacer(
              flex: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Pesanan Kamu Sudah Dibuat, Nih!",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Jangan lupa melakukan pembayaran untuk melanjutkan proses transaksi, ya!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff7C7C7C),
                    fontWeight: FontWeight.w600),
              ),
            ),
            Spacer(
              flex: 8,
            ),
            AppButton(
              label: "Lihat Pesanan",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Spacer(
              flex: 2,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                "Kembali ke Hidrocommerce",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Spacer(
              flex: 10,
            ),
          ],
        ),
      ),
    );
  }
}
