import 'package:Apehipo/modules/order/order_screen.dart';
import 'package:Apehipo/splash/splash_screen.dart';
import 'package:Apehipo/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TrackScreen extends StatefulWidget {
  const TrackScreen({super.key});

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
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
          "Status Pesanan",
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Icon(
                    Icons.delivery_dining,
                    size: 100,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: AppText(
                    text: "Produk Anda disortir dari Bandung",
                    fontSize: 20,
                    textAlign: TextAlign.center,
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
