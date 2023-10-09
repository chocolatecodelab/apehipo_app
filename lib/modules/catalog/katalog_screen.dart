import 'package:apehipo_app/auth/auth_controller.dart';
import 'package:apehipo_app/modules/account/account_screen.dart';
import 'package:apehipo_app/modules/catalog/catalog_controller.dart';
import 'package:apehipo_app/modules/catalog/catalog_model.dart';
import 'package:apehipo_app/modules/catalog/catalog_tambah.dart';
import 'package:apehipo_app/modules/dashboard/dashboard_screen.dart';
import 'package:get/get.dart';
import 'catalog_edit.dart';
import 'package:apehipo_app/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:apehipo_app/widgets/colors.dart';
import 'package:apehipo_app/widgets/catalog_item_widget.dart';

class CatalogScreen extends StatefulWidget {
  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  @override
  var controller = Get.put(CatalogController());
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Katalog",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent,
            elevation: 0,
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
                        'Produk Tampil',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Produk Arsip',
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
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => controller.isLoading.value
                          ? Center(child: CircularProgressIndicator())
                          : controller.dataTampilList!.isEmpty
                              ? Center(child: Text("Tidak ada Produk"))
                              : SingleChildScrollView(
                                  child: Center(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        padded(subTitle("Produk Anda")),
                                        getVerticalItemSlider(
                                            controller.dataTampilList!),
                                      ],
                                    ),
                                  ),
                                ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: getTambahButton(context, "Tambah Produk Baru"),
                    )
                  ]),
            ),
            SafeArea(
                child: Column(children: [
              Obx(
                () => controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : controller.dataArsipList!.isEmpty
                        ? Center(child: Text("Tidak ada data"))
                        : SingleChildScrollView(
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  padded(subTitle("Arsip Anda")),
                                  getVerticalItemSlider(
                                      controller.dataArsipList!),
                                ],
                              ),
                            ),
                          ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: getTambahButton(context, "Tambah Produk Baru"),
              )
            ]))
          ]),
        ));
  }

  Widget getTambahButton(BuildContext context, label,
      {Widget? trailingWidget}) {
    return Container(
      width: 350,
      child: ElevatedButton(
        onPressed: () {
          Get.to(CatalogTambahScreen());
          controller.clearData();
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => CatalogTambahScreen(),
          //   ),
          // );
        },
        style: ElevatedButton.styleFrom(
          visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
          textStyle: TextStyle(
            color: Colors.white,
            fontFamily: gilroyFontFamily,
          ),
          padding: EdgeInsets.symmetric(vertical: 24),
          minimumSize: const Size.fromHeight(50),
        ),
        child: Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
              ],
            )),
            if (trailingWidget != null)
              Positioned(
                top: 0,
                right: 25,
                child: trailingWidget,
              ),
          ],
        ),
      ),
    );
  }

  Widget padded(Widget widget) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: widget,
    );
  }

  Widget getVerticalItemSlider(List<CatalogModel> items) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 490,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: items.length,
        scrollDirection:
            Axis.vertical, // Mengubah scrollDirection menjadi vertical
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onItemClicked(context, items[index]);
            },
            child: CatalogItemWidget(
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

  void onItemClicked(BuildContext context, CatalogModel katalogItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CatalogEditScreen(
                katalogItem,
                heroSuffix: "account_katalog",
              )),
    );
  }

  Widget subTitle(String text) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Spacer(),
      ],
    );
  }
}
