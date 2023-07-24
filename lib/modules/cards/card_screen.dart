import 'package:apehipo_app/modules/dashboard/dashboard_screen.dart';
import 'package:apehipo_app/modules/product_details/product_details_screen.dart';
import 'package:apehipo_app/widgets/card.dart';
import 'package:apehipo_app/widgets/catalog_item_widget.dart';

import '../../widgets/search_bar.dart';
import 'package:apehipo_app/modules/home/models/grocery_item.dart';
import 'package:flutter/material.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ScaffoldExample(),
    );
  }
}

enum SampleItem { itemOne, itemTwo, itemThree }
class FilterButton extends StatefulWidget {
  const FilterButton({super.key});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PopupMenuButton<SampleItem>(
          initialValue: selectedMenu,
          onSelected: (SampleItem item) {
            setState(() {
              selectedMenu = item;
            });
          },

          itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>> [
            const PopupMenuItem<SampleItem> (
              value: SampleItem.itemOne,
              child: Text("Item 1"),
            ),
            const PopupMenuItem<SampleItem> (
              value: SampleItem.itemTwo,
              child: Text("Item 2"),
            )
          ],
        ),
      ),
    );
  }
}

class ScaffoldExample extends StatelessWidget {
  const ScaffoldExample({super.key});

  @override
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
            Navigator.of(context).pushReplacement(new MaterialPageRoute(
                builder: (BuildContext context) {
                  return DashboardScreen();
                },
              ));
          },
        ),
        title: Container(
          width: double.infinity,
          child: SearchBarWidgets(),
        ),
        actions: [
           PopupMenuButton(
            icon: Icon(Icons.filter_list_alt, color: Colors.black,),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              const PopupMenuItem(
                child: Text('Working a lot harder'),
              ),
              const PopupMenuItem(
                child: Text('Being a lot smarter'),
              ),
              const PopupMenuItem(
                child: Text('Being a self-starter'),
              ),
              const PopupMenuItem(
                child: Text('Placed in charge of trading charter'),
              ),
            ]
           ),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: getItemWidget(demoItems),
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
      )
    );
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