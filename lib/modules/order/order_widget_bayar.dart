import 'package:apehipo_app/modules/notification/notification_controller.dart';
import 'package:apehipo_app/modules/order/order_controller.dart';
import 'package:apehipo_app/modules/order/order_model.dart';
import 'package:apehipo_app/widgets/confirmation_dialog.dart';
import 'package:apehipo_app/widgets/success_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:apehipo_app/widgets/LineSeparator.dart';
import 'package:apehipo_app/widgets/theme.dart';
import 'package:apehipo_app/widgets/app_text.dart';
import 'package:apehipo_app/widgets/colors.dart';
import 'package:get/get.dart';

class OrderWidgetBayar extends StatefulWidget {
  final Key key;
  final List<OrderModel> items;
  final OrderModel item;
  final String? heroSuffix;
  final VoidCallback? onAddPressed;

  OrderWidgetBayar({
    required this.key,
    required this.items,
    required this.item,
    this.heroSuffix,
    this.onAddPressed,
  });

  @override
  State<OrderWidgetBayar> createState() => _OrderWidgetBayarState();
}

class _OrderWidgetBayarState extends State<OrderWidgetBayar> {
  final Color borderColor = Color(0xffE2E2E2);
  final double borderRadius = 18;
  String status = "";
  String textStatus = "";
  late IconData iconDesc;
  var controller = Get.put(OrderController());
  @override
  void initState() {
    super.initState();
    status = widget.item.statusTransaksi!;
    if (status == "sudah bayar") {
      iconDesc = Icons.payment_outlined;
      textStatus = "Pembayaran telah berhasil";
    } else if (status == "proses") {
      iconDesc = Icons.directions_car_filled_outlined;
      textStatus = "Pesanan sedang diproses toko";
    } else if (status == "antar") {
      iconDesc = Icons.watch_later_outlined;
      textStatus = "Pesanan sedang dalam perjalanan";
    } else {
      iconDesc = Icons.playlist_add_check_circle_outlined;
      textStatus = "Pesanan sudah diterima";
    }
  }

  @override
  Widget build(BuildContext context) {
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
              AppText(
                text: "Status: ",
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              Row(
                children: [
                  Icon(iconDesc),
                  SizedBox(
                    width: 5,
                  ),
                  AppText(
                    text: textStatus,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
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
                  Expanded(
                    child: getBayarButton(
                      context,
                      "Konfirmasi Pesanan",
                      widget.item.totalHarga,
                      status,
                      widget.item.idOrder,
                      widget.item.status,
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

Widget getBayarButton(
    BuildContext context,
    String label,
    String totalHarga,
    String statusTransaksi,
    String? idOrder,
    String status,
    String idPembeli,
    String idPenjual,
    {Widget? trailingWidget}) {
  var controller = Get.put(OrderController());
  var notificationController = Get.put(NotificationController());
  String idPengirim = idPembeli;
  String idPenerima = idPenjual;
  String pesan = "Pesanan dengan id: " + idOrder!;
  String detailPesan = "Pesanan sudah diterima pelanggan/pembeli.";
  String color = "hijau";
  return Container(
    width: 150,
    height: 50,
    child: ElevatedButton(
      onPressed: statusTransaksi != "antar"
          ? null
          : () async {
              bool? confirmationResult = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ConfirmationDialog(
                      message: "Apakah Anda telah menerima barang?");
                },
              );
              if (confirmationResult == true) {
                controller.ubahStatus(idOrder, totalHarga, status, idPembeli);
                notificationController.sendData(
                    pesan, detailPesan, idPenerima, idPengirim);
                SuccessConfirmationDialog(
                    message: "Terimakasih atas konfirmasinya",
                    icon: Icons.check_circle_outline);
                color = "abu";
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
        backgroundColor:
            color == "hijau" ? AppColors.primaryColor : AppColors.darkGrey,
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
