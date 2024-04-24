import 'package:Apehipo/modules/auth/controller/auth_controller.dart';
import 'package:Apehipo/modules/hidrocommerce/controller/hidrocommerce_controller.dart';
import 'package:Apehipo/modules/hidrocommerce/screen/hidrocommerce_detail_produk_screen.dart';
import 'package:Apehipo/modules/notification/controller/notification_controller.dart';
import 'package:Apehipo/modules/order/controller/order_controller.dart';
import 'package:Apehipo/modules/order/model/order_model.dart';
import 'package:Apehipo/modules/order/screen/payment_screen.dart';
import 'package:Apehipo/widgets/confirmation_dialog.dart';
import 'package:Apehipo/widgets/success_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:Apehipo/widgets/LineSeparator.dart';
import 'package:Apehipo/widgets/theme.dart';
import 'package:Apehipo/widgets/app_text.dart';
import 'package:Apehipo/widgets/colors.dart';
import 'package:get/get.dart';

class OrderBelumBayarWidget extends StatefulWidget {
  final String? waktu;
  final Key? key;
  final List<OrderModel> items;
  final OrderModel item;
  final String? heroSuffix;
  final VoidCallback? onAddPressed;

  OrderBelumBayarWidget({
    this.waktu,
    required this.key,
    required this.items,
    required this.item,
    this.heroSuffix,
    this.onAddPressed,
  });

  @override
  State<OrderBelumBayarWidget> createState() => _OrderBelumBayarWidgetState();
}

class _OrderBelumBayarWidgetState extends State<OrderBelumBayarWidget> {
  final Color borderColor = Color(0xffE2E2E2);
  final double borderRadius = 18;

  String formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitHours = twoDigits(duration.inHours.remainder(60));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    var homeController = Get.put(HidrocommerceController());
    final auth = Get.put(AuthController());
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
        ),
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true, // Ini penting untuk membatasi tinggi ListView
                physics:
                    NeverScrollableScrollPhysics(), // Nonaktifkan guliran ListView
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  int searchIndex = homeController.dataList!.indexWhere(
                      (item) => item.kode == widget.items[index].idProduk);
                  final item = widget.items[index];
                  return GestureDetector(
                    onTap: () {
                      if (searchIndex != -1) {
                        Get.to(HidrocommerceDetailProdukScreen(
                            homeController.dataList![searchIndex]));
                        // Item ditemukan, Anda dapat mengaksesnya dengan homeController.dataList[index].
                        // Lakukan sesuatu dengan item ini.
                      } else {
                        // Item tidak ditemukan.
                      }
                    },
                    child: Row(
                      children: [
                        Hero(
                          tag:
                              "KatalogItem:${item.nama}-${widget.heroSuffix ?? ""}",
                          child: imageWidget(item.foto),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                text: item.nama,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              AppText(
                                text: "x" + item.amount,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              AppText(
                                text:
                                    "Rp${getTotalPrice(item.harga, item.amount).toStringAsFixed(0)}",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: 15,
              ),
              LineSeparator(
                height: 1,
                color: const Color.fromARGB(255, 211, 211, 211),
              ),
              SizedBox(
                height: 15,
              ),
              StreamBuilder<Duration>(
                stream: timerStream(
                    widget.item.waktuKedaluarsa,
                    widget.item
                        .idOrder!), // Gantilah ini dengan Stream yang sesuai
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    String formattedDuration = formatDuration(snapshot.data!);
                    return Row(
                      children: [
                        AppText(
                          text: "Batas akhir pembayaran: ",
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        AppText(
                          text: formattedDuration,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ],
                    );
                  } else {
                    return CircularProgressIndicator(); // Tampilkan loading spinner jika data belum tersedia
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              AppText(
                text: "Total: Rp${widget.item.totalHarga}",
                textAlign: TextAlign.right,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  getCancelButton(
                    context,
                    "Batalkan",
                    widget.item.idOrder,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  getBayarButton(context, "Bayar", widget.item.totalHarga,
                      widget.item.buktiPembayaran, widget.item.idOrder)
                ],
              ),
              // error nanti jika K nya besar
              SizedBox(
                height: 10,
              ),
              if (auth.box.read("role") == "admin")
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: getKonfirmasi(
                        context,
                        "Konfirmasi",
                        widget.item.totalHarga,
                        widget.item.status,
                        widget.item.idOrder,
                        widget.item.idPembeli,
                        widget.item.idPenjual,
                      ),
                    )
                  ],
                )
            ],
          )),
    );
  }

  int getTotalPrice(String harga, String amount) {
    int currentHarga = int.parse(harga);
    int currentAmount = int.parse(amount);
    return currentHarga * currentAmount;
  }

  Stream<Duration> timerStream(
      DateTime waktuKedaluarsa, String idOrder) async* {
    var controller = Get.put(OrderController());
    while (DateTime.now().isBefore(waktuKedaluarsa)) {
      final selisihWaktu = waktuKedaluarsa.difference(DateTime.now());
      if (selisihWaktu.inSeconds <= 0) {
        break; // Hentikan stream jika selisih waktu kurang dari atau sama dengan 0
      }
      yield selisihWaktu;
      await Future.delayed(Duration(seconds: 1)); // Delay setiap detik
    }
    controller.deleteData(idOrder);
  }

  Widget imageWidget(String foto) {
    return Container(
      child: Image.network(foto),
      width: 100,
      height: 100,
    );
  }

  Widget editWidget() {
    return GestureDetector(
      onTap: widget.onAddPressed,
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: Colors.amber,
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.edit_square,
              color: Colors.white,
              size: 25,
            ),
          ],
        )),
      ),
    );
  }
}

Widget getCancelButton(BuildContext context, String label, String? idOrder,
    {Widget? trailingWidget}) {
  var controller = Get.put(OrderController());
  return Container(
    width: 150,
    height: 50,
    child: ElevatedButton(
      onPressed: () async {
        bool? confirmationResult = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return ConfirmationDialog(
                message: "Apakah Anda yakin ingin membatalkan Orderan?");
          },
        );
        if (confirmationResult == true) {
          bool? hasil = await controller.deleteData(idOrder);
          if (hasil) {
            SuccessConfirmationDialog(
                message: "Order anda telah dibatalkan",
                icon: Icons.check_circle_outline);
          }
        } else {
          SuccessConfirmationDialog(
              message: "Order anda gagal untuk dibatalkan",
              icon: Icons.close_sharp);
        }
      },
      style: ElevatedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        elevation: 0,
        backgroundColor: Colors.red[400],
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
                  color: AppColors.whiteGrey,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Icon(
                Icons.cancel_outlined,
                size: 18,
                color: Colors.white,
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

Widget getBayarButton(BuildContext context, String label, String totalHarga,
    String? buktiPembayaran, String? idOrder,
    {Widget? trailingWidget}) {
  return Container(
    width: 150,
    height: 50,
    child: ElevatedButton(
      onPressed: () => {
        // Get.to(PaymentPage("02020020"))
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PaymentScreen(totalHarga, buktiPembayaran!, idOrder!),
            )),
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
                  color: AppColors.whiteGrey,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Icon(
                Icons.payment_outlined,
                size: 18,
                color: Colors.white,
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

Widget getKonfirmasi(BuildContext context, String label, String totalHarga,
    String status, String? idOrder, String idPembeli, String idPenjual,
    {Widget? trailingWidget}) {
  String idPengirim = idPembeli;
  String idPenerima = idPenjual;
  String pesan = "";
  String detailPesan = "";
  if (status == "belum bayar") {
    pesan = "Pesanan baru dengan id: " + idOrder!;
    detailPesan = "Segera proses pesanan baru dari pelanggan ya!";
  } else if (status == "sudah bayar") {
    pesan = "Pesanan selesai dengan id: " + idOrder!;
    detailPesan = "Terimakasih atas layanan anda, semoga tokonya berkah!";
  }
  final controller = Get.put(OrderController());
  final notifikasiController = Get.put(NotificationController());
  return Container(
    width: 150,
    height: 50,
    child: ElevatedButton(
      onPressed: () async {
        bool? hasil =
            await controller.ubahStatus(idOrder, totalHarga, status, idPembeli);
        if (hasil) {
          notifikasiController.sendData(
              pesan, detailPesan, idPenerima, idPengirim);
          print("sukses");
        }
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
              Icon(
                Icons.payment_outlined,
                size: 18,
                color: Colors.white,
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

// void onItemClicked(BuildContext context, CatalogModel katalogItem) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//         builder: (context) => CatalogEditScreen(
//               katalogItem,
//               heroSuffix: "account_katalog",
//             )),
//   );
// }
