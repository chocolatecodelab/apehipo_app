import 'package:Apehipo/modules/cart/controller/cart_controller.dart';
import 'package:Apehipo/modules/cart/model/cart_model.dart';
import 'package:Apehipo/modules/hidrocommerce/controller/hidrocommerce_controller.dart';
import 'package:Apehipo/modules/hidrocommerce/screen/hidrocommerce_detail_produk_screen.dart';
import 'package:Apehipo/modules/order/screen/order_accepted_screen.dart';
import 'package:Apehipo/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:Apehipo/widgets/app_button.dart';
import 'package:Apehipo/widgets/column_with_seprator.dart';
import 'package:Apehipo/modules/cart/screen/widget/cart_item_widget.dart';
import 'package:get/get.dart';

import 'checkout_bottom_sheet_screen.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double totalHarga = 0;
  var homeController = Get.put(HidrocommerceController());

  var controller = Get.put(CartController());
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
                Obx(() => controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : controller.dataList!.isEmpty
                        ? Center(child: Text("Tidak ada data."))
                        : Column(
                            children: [
                              ...getChildrenWithSeperator(
                                addToLastChild: false,
                                widgets: controller.dataList!
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  CartModel cartItem = entry
                                      .value; // Dapatkan elemen dari CartModel

                                  int homeModelIndex = homeController.dataList!
                                      .indexWhere((homeItem) =>
                                          homeItem.kode == cartItem.id);
                                  print(homeModelIndex);
                                  CartModel e = entry.value;
                                  return InkWell(
                                    onTap: () {
                                      if (homeModelIndex != -1) {
                                        // Jika indeks ditemukan, navigasikan ke layar detail dengan HomeModel yang sesuai
                                        Get.to(HidrocommerceDetailProdukScreen(
                                            homeController
                                                .dataList![homeModelIndex]));
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 25,
                                      ),
                                      width: double.maxFinite,
                                      child: ChartItemWidget(
                                        item: e,
                                      ),
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
                          )),
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
        style:
            TextStyle(fontWeight: FontWeight.w600, color: AppColors.whiteGrey),
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
