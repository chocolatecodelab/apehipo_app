import 'package:Apehipo/modules/hidrocommerce/screen/hidrocommerce_detail_produk_screen.dart';
import 'package:Apehipo/modules/hidrocommerce/model/hidrocommerce_model.dart';
import 'package:Apehipo/modules/hidrocommerce/screen/widget/card_klasifikasi_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HidrocommerceKlasifikasiScreen extends StatefulWidget {
  final String? klasifikasi;
  final String title;
  final List<HidrocommerceModel>? items;

  const HidrocommerceKlasifikasiScreen(
      this.klasifikasi, this.title, this.items);

  @override
  State<HidrocommerceKlasifikasiScreen> createState() =>
      _HidrocommerceKlasifikasiScreenState();
}

class _HidrocommerceKlasifikasiScreenState
    extends State<HidrocommerceKlasifikasiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
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
      ),
      body: SafeArea(
          child: Container(
        child: getItemWidget(widget.items!),
      )),
    );
  }

  Widget getItemWidget(List<HidrocommerceModel> items) {
    return Container(
        child: GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 245,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            onItemClicked(context, items[index]);
          },
          child: CardKlasifikasiWidget(
            item: items[index],
            context: context,
          ),
        );
      },
    ));
  }

  void onItemClicked(BuildContext context, HidrocommerceModel dashboardItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HidrocommerceDetailProdukScreen(
                dashboardItem,
                heroSuffix: "home_screen",
              )),
    );
  }
}


  // Widget getItemCard(List<GroceryItem> items) {
  //   return Container(
  //     child: CardWidget(),
  //   );
  // 