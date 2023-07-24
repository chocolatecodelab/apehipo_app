import 'package:apehipo_app/modules/dashboard/dashboard_screen.dart';
import 'package:apehipo_app/modules/product_details/product_details_screen.dart';
import 'package:apehipo_app/widgets/card.dart';
import 'package:apehipo_app/widgets/catalog_item_tampil_widget.dart';
import 'package:apehipo_app/widgets/search_bar_widget.dart';

import 'package:apehipo_app/modules/home/models/grocery_item.dart';
import 'package:flutter/material.dart';

class BestSellingOffer extends StatelessWidget {
  const BestSellingOffer({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ScaffoldExample(),
    );
  }
}

class ScaffoldExample extends StatelessWidget {
  const ScaffoldExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Best Selling",
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
        child: getItemWidget(bestSelling),
      )),
    );
  }

  Widget getItemWidget(List<GroceryItem> items) {
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
        return GestureDetector(
          onTap: () {
            onItemClicked(context, items[index]);
          },
          child: CardItem(
            item: items[index],
          ),
        );
      },
    ));
  }

  void onItemClicked(BuildContext context, GroceryItem groceryItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(
                groceryItem,
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