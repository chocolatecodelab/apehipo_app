import 'package:Apehipo/modules/dashboard/dashboard_screen.dart';
import 'package:Apehipo/modules/order/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Apehipo/widgets/app_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderAcceptedScreen extends StatefulWidget {
  @override
  State<OrderAcceptedScreen> createState() => _OrderAcceptedScreenState();
}

class _OrderAcceptedScreenState extends State<OrderAcceptedScreen> {
  late DateTime currentTimePlus2Hours;
  late String formattedTime;

  @override
  void initState() {
    super.initState();

    // Mendapatkan waktu saat ini
    final currentTime = DateTime.now();

    // Menambahkan 2 jam ke waktu saat ini
    currentTimePlus2Hours = currentTime.add(Duration(hours: 2));
    formattedTime = DateFormat('HH:mm:ss').format(currentTimePlus2Hours);
  }

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
                Get.off(OrderScreen());
              },
            ),
            Spacer(
              flex: 2,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DashboardScreen();
                    });
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
