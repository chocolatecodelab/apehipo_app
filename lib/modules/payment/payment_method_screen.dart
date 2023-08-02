import 'package:apehipo_app/modules/order/order_screen.dart';
import 'package:apehipo_app/splash/splash_screen.dart';
import 'package:apehipo_app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
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
          "Pilih Metode Pembayaran",
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
        child: ListView(
          padding: EdgeInsets.all(8),
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xffE2E2E2),
                ),
                borderRadius: BorderRadius.circular(18)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/ic_google.png"),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xffE2E2E2),
                ),
                borderRadius: BorderRadius.circular(18)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/ic_google.png"),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
