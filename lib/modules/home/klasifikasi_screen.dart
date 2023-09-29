import 'package:apehipo_app/modules/home/product_all_detail.dart';
import 'package:apehipo_app/modules/home/home_model.dart';
import 'package:apehipo_app/widgets/card_item_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KlasifikasiScreen extends StatefulWidget {
  final String? klasifikasi;
  final String title;
  final List<HomeModel>? items;

  const KlasifikasiScreen(this.klasifikasi, this.title, this.items);

  @override
  State<KlasifikasiScreen> createState() => _KlasifikasiScreenState();
}

class _KlasifikasiScreenState extends State<KlasifikasiScreen> {
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

  Widget getItemWidget(List<HomeModel> items) {
    return Container(
        child: GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 225,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            onItemClicked(context, items[index]);
          },
          child: CardItemDashboard(
            item: items[index],
            context: context,
          ),
        );
      },
    ));
  }

  void onItemClicked(BuildContext context, HomeModel dashboardItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProductDetailScreen(
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