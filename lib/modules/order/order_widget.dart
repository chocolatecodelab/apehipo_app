import 'package:apehipo_app/auth/auth_controller.dart';
import 'package:apehipo_app/modules/notification/notification_controller.dart';
import 'package:apehipo_app/modules/order/order_controller.dart';
import 'package:apehipo_app/modules/order/order_model.dart';
import 'package:apehipo_app/modules/payment/payment_screen.dart';
import 'package:apehipo_app/widgets/confirmation_dialog.dart';
import 'package:apehipo_app/widgets/success_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:apehipo_app/widgets/LineSeparator.dart';
import 'package:apehipo_app/widgets/theme.dart';
import 'package:apehipo_app/widgets/app_text.dart';
import 'package:apehipo_app/widgets/colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderWidget extends StatefulWidget {
  final String? waktu;
  final Key key;
  final List<OrderModel> items;
  final OrderModel item;
  final String? heroSuffix;
  final VoidCallback? onAddPressed;

  OrderWidget({
    this.waktu,
    required this.key,
    required this.items,
    required this.item,
    this.heroSuffix,
    this.onAddPressed,
  });

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
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
    // Format tanggal dan waktu dalam format yang diinginkan

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
                  final item = widget.items[index];
                  return Row(
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
                              text: "Rp${item.harga}",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ],
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
                  getBayarButton(
                    context,
                    "Bayar",
                    widget.item.totalHarga,
                  )
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
                      child: auth.box.read("role") == "konsumen"
                          ? getKonfirmasi(
                              context,
                              "Konfirmasi",
                              widget.item.totalHarga,
                              widget.item.status,
                              widget.item.idOrder,
                              widget.item.idPembeli,
                              widget.item.idPenjual,
                            )
                          : Text(""),
                    )
                  ],
                )
            ],
          )),
    );
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
  var auth = Get.put(AuthController());
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
              builder: (context) => PaymentScreen(totalHarga),
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
