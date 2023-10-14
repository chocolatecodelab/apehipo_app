import 'package:Apehipo/auth/auth_controller.dart';
import 'package:Apehipo/modules/notification/notification_change.dart';
import 'package:Apehipo/modules/notification/notification_controller.dart';
import 'package:Apehipo/modules/notification/notif_model.dart';
import 'package:Apehipo/modules/order/order_screen.dart';
import 'package:Apehipo/modules/transaction/transaction_screen.dart';
import 'package:Apehipo/widgets/delete_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var notificationController = Get.put(NotificationController());
  String status = "";
  @override
  void initState() {
    super.initState();
    notificationController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    var notificationController = Get.put(NotificationController());
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Notifikasi",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 80,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Container(
          child: Obx(() => notificationController.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : notificationController.dataList!.isEmpty
                  ? Center(child: Text("Tidak ada data"))
                  : listViewMethod(notificationController.dataList!)),
        ));
  }

  Widget listViewMethod(List<NotifModel> dataNotification) {
    dataNotification.sort((a, b) {
      // Mengambil angka dari idOrder menggunakan ekstraksi substring
      int aOrderNumber = int.parse(
          a.id.substring(1)); // Mengabaikan karakter pertama (biasanya 'O')
      int bOrderNumber = int.parse(b.id.substring(1));

      // Membandingkan angka-angka tersebut
      return bOrderNumber.compareTo(aOrderNumber);
    });
    var auth = Get.put(AuthController());
    return ListView.separated(
      itemCount: dataNotification.length,
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 5,
        );
      },
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (auth.box.read("role") == "petani") {
              Get.to(TransactionScreen());
            } else {
              Get.to(OrderScreen());
            }
          },
          child: listViewItem(dataNotification[index]),
        );
      },
    );
  }

  Widget listViewItem(NotifModel dataNotification) {
    var controller = Get.put(NotificationController());
    final notif = Provider.of<NotificationChange>(context);
    List<NotifModel> notifTidakTerbaca = notificationController.dataList!
        .where((x) => x.status == "false")
        .toList();
    return Container(
      color: dataNotification.status == "false"
          ? Color.fromARGB(255, 235, 235, 235)
          : Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          prefixIcon(),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  message(dataNotification),
                  SizedBox(
                    height: 5,
                  ),
                  detailMessage(dataNotification),
                  timeAndDate(dataNotification),
                  TextButton(
                    onPressed: dataNotification.status == "false"
                        ? () async {
                            String hasil =
                                await controller.ubahData(dataNotification.id);
                            if (hasil == "sukses") {
                              notif.incrementCounter(notifTidakTerbaca.length);
                            }
                          }
                        : null,
                    child: Text(
                      dataNotification.status == "false"
                          ? "Tandai pesan telah dibaca"
                          : "",
                      style: TextStyle(
                        color: Colors.green, // Warna teks
                        fontWeight: FontWeight.bold, // Ketebalan teks
                        fontSize: 16, // Ukuran teks
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: InkWell(
              onTap: () async {
                bool? confirmationResult = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DeleteConfirmationDialog(
                        message: "Apakah anda yakin ingin menghapus produk?");
                  },
                );
                if (confirmationResult == true) {
                  controller.deleteData(dataNotification.id);
                } else {
                  print("Gagal");
                }
              },
              child: Icon(
                Icons.delete_outline,
                color: const Color.fromARGB(255, 193, 45, 34),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget prefixIcon() {
    return Container(
      height: 50,
      width: 50,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
      ),
      child: Icon(
        Icons.notifications_outlined,
        size: 25,
        color: Colors.black,
      ),
    );
  }

  Widget message(NotifModel dataNotification) {
    double textSize = 14;
    return Container(
      child: RichText(
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            text: dataNotification.pesan,
            style: TextStyle(
              fontSize: textSize,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }

  Widget detailMessage(NotifModel dataNotification) {
    double textSize = 14;
    return Container(
        child: RichText(
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        text: dataNotification.detailPesan,
        style: TextStyle(
          fontSize: textSize,
          color: Colors.black,
          fontWeight: FontWeight.w300,
        ),
      ),
    ));
  }

  Widget timeAndDate(NotifModel dataNotification) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            dataNotification.datetime,
            style: TextStyle(
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
