import 'package:apehipo_app/modules/order/order_screen.dart';
import 'package:apehipo_app/splash/splash_screen.dart';
import 'package:apehipo_app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (BuildContext context) {
                return OrderScreen();
              },
            ));
          },
        ),
        title: Text(
          "Pembayaran",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        margin: EdgeInsets.only(
          top: 20,
          bottom: 0,
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                AppText(
                  text: "Total Pembayaran",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                Spacer(),
                AppText(
                  text: "10,000",
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  textAlign: TextAlign.end,
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              children: [
                AppText(
                  text: "Batas Pembayaran",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                Spacer(),
                AppText(
                  text: "27 Agustus 2023 12:30 AM",
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  textAlign: TextAlign.end,
                ),
              ],
            ),
            SizedBox(height: 20,),
            Divider(thickness: 1, color: Colors.grey,),
            SizedBox(height: 20,),
            Row(
              children: [
                Icon(Icons.payment),
                SizedBox(width: 20,),
                AppText(
                  text: "Midtrans",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  textAlign: TextAlign.end,
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                SizedBox(width: 40,),
                AppText(
                  text: "Kode Pembayaran",
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  textAlign: TextAlign.end,
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(left: 40)),
                AppText(
                  text: "A51826W870000",
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  textAlign: TextAlign.start,
                ),
                SizedBox(width: 20,),
                Icon(Icons.copy,),
              ],
            ),
            SizedBox(height: 10,),
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 40),
              Expanded(
                child: AppText(
                  text: "Proses verifikasi kurang dari 10 menit setelah pembayaran berhasil.",
                  fontSize: 14,
                ),
              ),
            ],
            ),
            SizedBox(height: 10,),
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 40),
              Expanded(
                child: AppText(
                  text: "Bayar pesanan ke Virtual Account di atas sebelum membuat pesanan kembali dengan Virtual Account agar nomor tetap sama.",
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Divider(thickness: 1, color: Colors.grey,),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: AppText(
                  text: "Petunjuk Transfer\n",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            ),
            Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: AppText(
                  text: "1. Petunjuk transfer",
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
            ),
            Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: AppText(
                  text: "2. New Petunjuk transfer",
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
            ),
            Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: AppText(
                  text: "3. New New Petunjuk transfer",
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
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
