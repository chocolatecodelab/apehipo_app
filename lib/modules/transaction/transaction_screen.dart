import 'package:Apehipo/modules/transaction/transaction_controller.dart';
import 'package:Apehipo/modules/transaction/transaction_model.dart';
import 'package:Apehipo/modules/transaction/transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionScreen extends StatefulWidget {
  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  void initState() {
    super.initState();
    controller.refresh();
  }

  @override
  var controller = Get.put(TransactionController());
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
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Obx(
                          () => controller.isLoading.value
                              ? Center(child: CircularProgressIndicator())
                              : controller.dataProsesList!.isEmpty
                                  ? Center(child: Text("Tidak ada data"))
                                  : getVerticalTransaksi(
                                      controller.dataProsesList!),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SafeArea(
                child: Container(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => controller.isLoading.value
                            ? Center(child: CircularProgressIndicator())
                            : controller.dataSelesaiList!.isEmpty
                                ? Center(child: Text("Tidak ada data"))
                                : getVerticalTransaksi(
                                    controller.dataSelesaiList!),
                      )
                    ],
                  ),
                ),
              ),
            ))
          ]),
        ));
  }

  Widget getVerticalTransaksi(List<TransactionModel> items) {
    items.sort((a, b) {
      // Mengambil angka dari idOrder menggunakan ekstraksi substring
      int aOrderNumber = int.parse(a.idTransaksi
          .substring(1)); // Mengabaikan karakter pertama (biasanya 'O')
      int bOrderNumber = int.parse(b.idTransaksi.substring(1));

      // Membandingkan angka-angka tersebut
      return bOrderNumber.compareTo(aOrderNumber);
    });
    List<TransactionModel> filteredItems = [];
    Set<String> uniqueIds = Set<String>();
    for (var item in items) {
      if (!uniqueIds.contains(item.idTransaksi)) {
        filteredItems.add(item);
        uniqueIds.add(item.idTransaksi);
      }
    }
    print(filteredItems.length);
    List<Key> orderWidgetKeys =
        List.generate(filteredItems.length, (index) => UniqueKey());
    print(orderWidgetKeys);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 640,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: filteredItems.length,
        scrollDirection:
            Axis.vertical, // Mengubah scrollDirection menjadi vertical
        itemBuilder: (context, index) {
          List<TransactionModel> filtered2Items = items
              .where((x) => x.idTransaksi == filteredItems[index].idTransaksi)
              .toList();
          print(filtered2Items);
          return GestureDetector(
            onTap: () {
              // onItemClicked(context, items[index]);
            },
            child: TransactionWidget(
              key: orderWidgetKeys[index],
              items: filtered2Items,
              item: filteredItems[index],
              heroSuffix: "transaction",
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
}
