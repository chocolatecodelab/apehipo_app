import 'package:apehipo_app/modules/dashboard/dashboard_screen.dart';
import 'package:apehipo_app/modules/home/dashboard_controller.dart';
import 'package:apehipo_app/modules/home/dashboard_detail.dart';
import 'package:apehipo_app/modules/home/models/dashboard_model.dart';
import 'package:apehipo_app/widgets/card_item_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnTrending extends StatefulWidget {
  final String? klasifikasi;

  const OnTrending(this.klasifikasi);

  @override
  State<OnTrending> createState() => _OnTrendingState();
}

class _OnTrendingState extends State<OnTrending> {
  @override
  var controller = Get.put(DashboardController());
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sedang laris",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (BuildContext context) {
                return DashboardScreen();
              },
            ));
          },
        ),
      ),
      body: SafeArea(
          child: Container(
        child: getItemWidget(controller.dataList!),
      )),
    );
  }

  Widget getItemWidget(List<DashboardModel> items) {
    return Container(
        child: GridView.builder(
      padding: const EdgeInsets.all(30),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        if (items[index].klasifikasi == widget.klasifikasi) {
          return GestureDetector(
            onTap: () {
              onItemClicked(context, items[index]);
            },
            child: CardItemDashboard(
              item: items[index],
              context: context,
            ),
          );
        } else {
          return null;
        }
      },
    ));
  }

  void onItemClicked(BuildContext context, DashboardModel dashboardItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DashboardDetailScreen(
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