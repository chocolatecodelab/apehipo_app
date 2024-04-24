import 'package:Apehipo/modules/auth/controller/auth_controller.dart';
import 'package:Apehipo/modules/catalog/screen/catalog_edit_screen.dart';
import 'package:Apehipo/modules/catalog/model/catalog_model.dart';
import 'package:Apehipo/modules/hidrocommerce/controller/hidrocommerce_controller.dart';
import 'package:Apehipo/modules/hidrocommerce/screen/hidrocommerce_detail_produk_screen.dart';
import 'package:Apehipo/modules/order/controller/order_controller.dart';
import 'package:Apehipo/modules/order/model/order_model.dart';
import 'package:Apehipo/modules/order/screen/widget/order_belum_bayar_widget.dart';
import 'package:Apehipo/modules/order/screen/widget/order_widget_bayar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  final String? waktu;

  const OrderScreen({this.waktu});
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  var auth = Get.put(AuthController());
  var controller = Get.put(OrderController());
  var homeController = Get.put(HidrocommerceController());

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  Future<void> refreshData() async {
    await controller.refresh(); // Panggil metode refresh dari controller
    // Untuk menghentikan indikator refresh, panggil setState
    if (mounted) {
      setState(() {
        // Ini akan menghentikan indikator refresh
      });
    }
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Status Pembelian",
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
                Get.back();
                refreshData();
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
                        'Belum Bayar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Sudah Bayar',
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
              child: Obx(
                () => controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : controller.dataBelumList!.isEmpty
                        ? Center(child: Text("Tidak ada data"))
                        : SingleChildScrollView(
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  RefreshIndicator(
                                    key: _refreshKey,
                                    onRefresh: () => refreshData(),
                                    child: Column(
                                      children: [
                                        getVerticalItemSlider(
                                            controller.dataBelumList!),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
              ),
            )),
            SafeArea(
                child: Container(
              child: Obx(
                () => controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : controller.dataSudahList!.isEmpty
                        ? Center(child: Text("Tidak ada data"))
                        : SingleChildScrollView(
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  RefreshIndicator(
                                      child: Column(
                                        children: [
                                          getVerticalItemSlider2(
                                              controller.dataSudahList!),
                                        ],
                                        key: _refreshKey,
                                      ),
                                      onRefresh: () => refreshData())
                                ],
                              ),
                            ),
                          ),
              ),
            )),
          ]),
        ));
  }

  Widget getVerticalItemSlider(List<OrderModel> items) {
    items.sort((a, b) {
      // Mengambil angka dari idOrder menggunakan ekstraksi substring
      int aOrderNumber = int.parse(a.idOrder!
          .substring(1)); // Mengabaikan karakter pertama (biasanya 'O')
      int bOrderNumber = int.parse(b.idOrder!.substring(1));

      // Membandingkan angka-angka tersebut
      return bOrderNumber.compareTo(aOrderNumber);
    });
    List<OrderModel> filteredItems = [];
    Set<String> uniqueIds = Set<String>();
    for (var item in controller.dataBelumList!) {
      if (!uniqueIds.contains(item.idOrder)) {
        filteredItems.add(item);
        uniqueIds.add(item.idOrder!);
      }
    }
    List<Key> orderWidgetKeys =
        List.generate(filteredItems.length, (index) => UniqueKey());
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 600,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: filteredItems.length,
        scrollDirection:
            Axis.vertical, // Mengubah scrollDirection menjadi vertical
        itemBuilder: (context, index) {
          List<OrderModel> filtered2Items = items
              .where((x) => x.idOrder == filteredItems[index].idOrder)
              .toList();
          return Container(
            child: OrderBelumBayarWidget(
              key: orderWidgetKeys[index],
              items: filtered2Items,
              item: filteredItems[index],
              heroSuffix: "account_katalog",
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 10, // Mengubah width menjadi height
          );
        },
      ),
    );
  }

  Widget getVerticalItemSlider2(List<OrderModel> items) {
    items.sort((a, b) {
      // Mengambil angka dari idOrder menggunakan ekstraksi substring
      int aOrderNumber = int.parse(a.idOrder!
          .substring(1)); // Mengabaikan karakter pertama (biasanya 'O')
      int bOrderNumber = int.parse(b.idOrder!.substring(1));

      // Membandingkan angka-angka tersebut
      return bOrderNumber.compareTo(aOrderNumber);
    });
    List<OrderModel> filteredItems = [];
    Set<String> uniqueIds = Set<String>();
    for (var item in controller.dataSudahList!) {
      if (!uniqueIds.contains(item.idOrder)) {
        filteredItems.add(item);
        uniqueIds.add(item.idOrder!);
      }
    }
    List<Key> orderWidgetKeys =
        List.generate(items.length, (index) => UniqueKey());
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 600,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: filteredItems.length,
        scrollDirection:
            Axis.vertical, // Mengubah scrollDirection menjadi vertical
        itemBuilder: (context, index) {
          List<OrderModel> filtered2Items = items
              .where((x) => x.idOrder == filteredItems[index].idOrder)
              .toList();
          return GestureDetector(
            onTap: () {
              Get.to(HidrocommerceDetailProdukScreen(
                  homeController.dataList![index]));
            },
            child: OrderWidgetBayar(
              key: orderWidgetKeys[index],
              items: filtered2Items,
              item: filteredItems[index],
              heroSuffix: "account_katalog",
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 10, // Mengubah width menjadi height
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
}
