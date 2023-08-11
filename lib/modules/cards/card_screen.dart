import 'package:apehipo_app/modules/home/home_controller.dart';
import 'package:apehipo_app/modules/home/home_model.dart';
import 'package:apehipo_app/modules/product_details/product_details_screen.dart';
import 'package:apehipo_app/widgets/card_item.dart';
import '../contoh_api/product_controller.dart';
import 'package:apehipo_app/modules/contoh_api/product_model.dart';
import 'package:get/get.dart';

import '../../widgets/search_bar.dart';
import 'package:flutter/material.dart';

class CardScreen extends StatelessWidget {
  CardScreen({super.key});

  @override
  var controller = Get.put(HomeController());
  Widget build(BuildContext context) {
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
          PopupMenuButton(
              icon: Icon(
                Icons.filter_list_alt,
                color: Colors.black,
              ),
              offset:
                  Offset(0, 80), // Menggeser menu ke bawah sebesar 40 piksel
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                    const PopupMenuItem(
                      child: Text('Terbaru'),
                    ),
                    const PopupMenuItem(
                      child: Text('Terlaris'),
                    ),
                    const PopupMenuItem(
                      child: Text('Termurah'),
                    ),
                  ]),
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
