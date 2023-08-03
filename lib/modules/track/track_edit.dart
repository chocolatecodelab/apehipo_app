import 'package:apehipo_app/modules/order/order_screen.dart';
import 'package:apehipo_app/modules/track/track_edit_bottom.dart';
import 'package:apehipo_app/splash/splash_screen.dart';
import 'package:apehipo_app/widgets/app_button.dart';
import 'package:apehipo_app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TrackEditScreen extends StatefulWidget {
  const TrackEditScreen({super.key});

  @override
  State<TrackEditScreen> createState() => _TrackEditScreenState();
}

class _TrackEditScreenState extends State<TrackEditScreen> {
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
          "Edit Status Pesanan",
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
                Expanded(child: Icon(Icons.delivery_dining, size: 100,),)
              ],
            ),
            SizedBox(height: 10,),
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: AppText(
                  text: "Produk Anda disortir dari Bandung",
                  fontSize: 20,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
            ),
            SizedBox(height: 30,),
            AppButton(
              label: "Edit Status Pesanan",
              onPressed: () => {
                showBottomSheet(context),
              },
            ),
            ],
        ),
      ),
    );
  }

  void showBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return TrackEditBottom();
        });
  }
}
