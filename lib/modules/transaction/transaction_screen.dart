import 'package:apehipo_app/modules/account/models/katalog_item.dart';
import 'package:apehipo_app/modules/catalog/catalog_edit.dart';
import 'package:apehipo_app/modules/contoh_api/product_model.dart';
import 'package:apehipo_app/modules/product_details/product_details_screen.dart';
// import 'package:apehipo_app/modules/account/catalog_details.dart';
import 'package:apehipo_app/widgets/theme.dart';
import 'package:apehipo_app/widgets/transaction_widget_proses.dart';
import 'package:apehipo_app/widgets/transaction_widget_selesai.dart';
import 'package:flutter/material.dart';
// import 'package:apehipo_app/models/katalog_item.dart';
// import 'package:apehipo_app/screens/product_details/product_details_screen.dart';
import 'package:apehipo_app/widgets/colors.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:apehipo_app/widgets/catalog_item_arsip_widget.dart';
import 'package:apehipo_app/widgets/catalog_item_tampil_widget.dart';
import 'package:apehipo_app/widgets/app_button.dart';

class TransactionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Transaksi",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back, // Replace this with your custom icon
                color: Colors.black, // Customize the color of the icon
              ),
              onPressed: () {
                // Handle the back button press
                Navigator.of(context).pop();
              },
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.black.withOpacity(
                          0.2), // Customize the color of the top border
                      width: 2.0, // Customize the width of the top border
                    ),
                    bottom: BorderSide(
                      color: const Color.fromARGB(255, 165, 163,
                          163), // Customize the color of the border
                      width: 1.0, // Customize the width of the border
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 0,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: TabBar(
                  tabs: [
                    Tab(
                      child: Text(
                        'Proses',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Selesai',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(children: [
            SafeArea(
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      getVerticalTransaksiProsesSlider(penawaranSpesial),
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
                child: Container(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      getVerticalTransaksiSelesaiSlider(penjualanTerbaik),
                    ],
                  ),
                ),
              ),
            ))
          ]),
        ));
  }

  Widget getVerticalTransaksiProsesSlider(List<KatalogItem> items) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 750,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: items.length,
        scrollDirection:
            Axis.vertical, // Mengubah scrollDirection menjadi vertical
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // onItemClicked(context, items[index]);
            },
            child: TransactionProsesWidget(
              item: items[index],
              heroSuffix: "account_katalog",
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 20, // Mengubah width menjadi height
          );
        },
      ),
    );
  }

  Widget getVerticalTransaksiSelesaiSlider(List<KatalogItem> items) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 750,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: items.length,
        scrollDirection:
            Axis.vertical, // Mengubah scrollDirection menjadi vertical
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // onItemClicked(context, items[index]);
            },
            child: TransactionSelesaiWidget(
              item: items[index],
              heroSuffix: "account_katalog",
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 20, // Mengubah width menjadi height
          );
        },
      ),
    );
  }

  void onItemClicked(BuildContext context, KatalogItem katalogItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CatalogEditScreen(
                katalogItem,
                heroSuffix: "account_katalog",
              )),
    );
  }
}
