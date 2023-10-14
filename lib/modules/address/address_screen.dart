import 'package:Apehipo/modules/address/address_bottom_sheet.dart';
import 'package:Apehipo/modules/cart/cart_screen.dart';
import 'package:Apehipo/modules/order/order_screen.dart';
import 'package:Apehipo/splash/splash_screen.dart';
import 'package:Apehipo/widgets/app_button.dart';
import 'package:Apehipo/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Pilih Alamat",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        margin: EdgeInsets.only(
          top: 0,
          bottom: 0,
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Divider(),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Icon(Icons.pin_drop),
                SizedBox(
                  width: 20,
                ),
                AppText(
                  text: "Alamat sekarang",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  textAlign: TextAlign.end,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 40),
                Expanded(
                  child: AppText(
                    text: "Jl. HKSN Komplek Kebun Jeruk RT.15",
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Divider(),
            SizedBox(
              height: 15,
            ),
            AppButton(
              label: "Tambah Alamat",
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
          return AddressBottom();
        });
  }
}
