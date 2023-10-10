import 'package:Apehipo/modules/cart/cart_controller.dart';
import 'package:Apehipo/modules/order/order_accepted_screen.dart';
import 'package:flutter/material.dart';
import 'package:Apehipo/widgets/app_button.dart';
import 'package:Apehipo/widgets/column_with_seprator.dart';
import 'package:Apehipo/modules/home/models/grocery_item.dart';
import 'package:Apehipo/widgets/chart_item_widget.dart';
import 'package:get/get.dart';

import 'checkout_bottom_sheet.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double totalHarga = 0;
  var controller = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    controller.dataList!.sort((a, b) {
      // Mengambil angka dari idOrder menggunakan ekstraksi substring
      int aOrderNumber = int.parse(
          a.id!.substring(1)); // Mengabaikan karakter pertama (biasanya 'O')
      print(aOrderNumber);
      int bOrderNumber = int.parse(b.id!.substring(1));
      print(bOrderNumber);

      // Membandingkan angka-angka tersebut
      return bOrderNumber.compareTo(aOrderNumber);
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
          onPressed: () => {
            Get.back(),
          },
        ),
        title: Text(
          'Keranjang Belanja',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Obx(
                  () => controller.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : controller.dataList!.isEmpty
                          ? Center(child: Text("Tidak ada data."))
                          : Column(
                              children: [
                                ...getChildrenWithSeperator(
                                  addToLastChild: false,
                                  widgets: controller.dataList!.map((e) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 25,
                                      ),
                                      width: double.maxFinite,
                                      child: ChartItemWidget(
                                        item: e,
                                      ),
                                    );
                                  }).toList(),
                                  seperator: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 25,
                                    ),
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                getCheckoutButton(
                                    context), // Tambahkan tombol checkout di sini
                              ],
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getCheckoutButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: AppButton(
        label: "Check Out",
        fontWeight: FontWeight.w600,
        padding: EdgeInsets.symmetric(vertical: 30),
        trailingWidget: getButtonPriceWidget(),
        onPressed: () {
          showBottomSheet(context);
        },
      ),
    );
  }

  Widget getButtonPriceWidget() {
// Total harga akan berisi jumlah harga dari semua elemen dalam items
    if (controller.dataList != null && controller.dataList!.isNotEmpty) {
      totalHarga = controller.dataList!.map((item) {
        double harga = double.tryParse(item.harga) ?? 0.0;
        double amount = double.tryParse(item.amount.toString()) ?? 0.0;
        return harga * amount;
      }).reduce((a, b) => a + b);
    }
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Color(0xff489E67),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        totalHarga.toStringAsFixed(0),
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  void showBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return CheckoutBottomSheet(totalHarga.toString());
        }).then((result) => {
          if (result == "next") {Get.off(OrderAcceptedScreen())}
        });
  }
}
