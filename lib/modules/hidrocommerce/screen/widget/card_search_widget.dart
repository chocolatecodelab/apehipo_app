import '../../../auth/controller/auth_controller.dart';
import '../../../cart/screen/cart_change.dart';
import '../../controller/hidrocommerce_controller.dart';
import '../../model/hidrocommerce_model.dart';
import '../hidrocommerce_detail_produk_screen.dart';
import 'card_klasifikasi_widget.dart';
import '../../../../widgets/colors.dart';
import '../../../../widgets/success_confirmation_dialog.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'search_bar_input_widget.dart';
import 'package:flutter/material.dart';

class CardSearchWidget extends StatefulWidget {
  CardSearchWidget({super.key});

  @override
  State<CardSearchWidget> createState() => _CardSearchWidgetState();
}

class _CardSearchWidgetState extends State<CardSearchWidget> {
  var controller = Get.put(HidrocommerceController());

  Future<void> refreshData() async {
    await controller.refresh(); // Panggil metode refresh dari controller
    // Untuk menghentikan indikator refresh, panggil setState
    if (mounted) {
      setState(() {
        // Ini akan menghentikan indikator refresh
      });
    }
  }

  var auth = Get.put(AuthController());
  Widget build(BuildContext context) {
    Provider.of<CartChange>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            FocusScope.of(context).unfocus();
            refreshData();
            // Tombol hanya dapat diaktifkan jika tidak ada fokus dalam teks input
            Get.back();
          },
        ),
        title: Container(
          width: 250,
          child: SearchBarInputWidget(),
        ),
        actions: [
          Container(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              margin: EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () async {
                  String hasil =
                      await controller.getSpesifikData(controller.search.text);
                  if (hasil == "gagal") {
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SuccessConfirmationDialog(
                              message: "Produk gagal ditemukan",
                              icon: Icons.close_rounded);
                        });
                  }
                },
                child: Container(
                  height: 45,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: AppColors.primaryColor,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              )),
          // if (auth.box.read("role") == "konsumen")
          //   Container(
          //     margin: EdgeInsets.only(top: 20, right: 15),
          //     child: Stack(
          //       children: [
          //         Padding(
          //           padding: EdgeInsets.all(8),
          //           child: InkWell(
          //             onTap: () {
          //               Get.to(CartScreen());
          //             },
          //             child: SvgPicture.asset("assets/icons/cart_icon.svg"),
          //           ),
          //         ),
          //         Positioned(
          //           right: 0, // Menentukan posisi horizontal
          //           top: 0, // Menentukan posisi vertikal
          //           child: Container(
          //             padding: EdgeInsets.all(4),
          //             decoration: BoxDecoration(
          //               shape: BoxShape.circle,
          //               color: AppColors.primaryColor, // Warna latar belakang
          //             ),
          //             child: Text(
          //               cart.itemCount.toString(),
          //               style: TextStyle(
          //                 color: Colors.white, // Warna teks
          //                 fontSize: 12,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
        ],
      ),
      body: Container(
        child: Obx(
          () => controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : controller.dataList!.isEmpty
                  ? Center(child: Text("Tidak ada data."))
                  : Container(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 245,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        itemCount: controller.dataList!.length,
                        itemBuilder: (context, i) {
                          // String id = controller.dataList![i].kode;
                          return GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              Get.to(HidrocommerceDetailProdukScreen(
                                controller.dataList![i],
                                heroSuffix: "home screen",
                              ));
                            },
                            child: AspectRatio(
                              aspectRatio: 3 / 4,
                              child: Container(
                                child: CardKlasifikasiWidget(
                                  item: controller.dataList![i],
                                  context: context,
                                  heroSuffix: "product_search",
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
        ),
      ),
    );
  }

  void onItemClicked(
      BuildContext context, HidrocommerceModel hidrocommerceModel) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HidrocommerceDetailProdukScreen(
                hidrocommerceModel,
                heroSuffix: "home_screen",
              )),
    );
  }
}
