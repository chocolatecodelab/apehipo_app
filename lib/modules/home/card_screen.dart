import 'package:apehipo_app/modules/cart/cart_change.dart';
import 'package:apehipo_app/modules/cart/cart_screen.dart';
import 'package:apehipo_app/modules/home/home_controller.dart';
import 'package:apehipo_app/modules/home/home_model.dart';
import 'package:apehipo_app/modules/product_details/product_details_screen.dart';
import 'package:apehipo_app/widgets/card_item.dart';
import 'package:apehipo_app/widgets/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../widgets/search_bar.dart';
import 'package:flutter/material.dart';

class CardScreen extends StatefulWidget {
  CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  var controller = Get.put(HomeController());

  Widget build(BuildContext context) {
    final cart = Provider.of<CartChange>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
        title: Container(
          width: double.infinity,
          child: SearchBarWidgets(),
        ),
        actions: [
          // PopupMenuButton(
          //     icon: Icon(
          //       Icons.filter_list_alt,
          //       color: Colors.black,
          //     ),
          //     offset:
          //         Offset(0, 80), // Menggeser menu ke bawah sebesar 40 piksel
          //     itemBuilder: (BuildContext context) => <PopupMenuEntry>[
          //           const PopupMenuItem(
          //             child: Text('Terbaru'),
          //           ),
          //           const PopupMenuItem(
          //             child: Text('Terlaris'),
          //           ),
          //           const PopupMenuItem(
          //             child: Text('Termurah'),
          //           ),
          //         ]),
          Container(
            margin: EdgeInsets.only(top: 20, right: 15),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {
                      Get.to(CartScreen());
                    },
                    child: SvgPicture.asset("assets/icons/cart_icon.svg"),
                  ),
                ),
                Positioned(
                  right: 0, // Menentukan posisi horizontal
                  top: 0, // Menentukan posisi vertikal
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor, // Warna latar belakang
                    ),
                    child: Text(
                      cart.itemCount.toString(),
                      style: TextStyle(
                        color: Colors.white, // Warna teks
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        child: Obx(
          () => controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : controller.dataList!.isEmpty
                  ? Center(child: Text("Tidak ada data."))
                  : GridView.builder(
                      padding: const EdgeInsets.all(10),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: controller.dataList!.length,
                      itemBuilder: (context, i) {
                        // String id = controller.dataList![i].kode;
                        return GestureDetector(
                          onTap: () {
                            Get.to(ProductDetailsScreen(
                              controller.dataList![i],
                              heroSuffix: "home screen",
                            ));
                          },
                          child: AspectRatio(
                            aspectRatio: 3 / 4,
                            child: CardItem(
                              item: controller.dataList![i],
                              context: context,
                              heroSuffix: "product_search",
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }

  void onItemClicked(BuildContext context, HomeModel productModel) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(
                productModel,
                heroSuffix: "home_screen",
              )),
    );
  }
}
