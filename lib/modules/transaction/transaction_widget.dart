import 'package:apehipo_app/modules/catalog/catalog_edit.dart';
import 'package:apehipo_app/modules/catalog/catalog_model.dart';
import 'package:apehipo_app/modules/notification/notification_controller.dart';
import 'package:apehipo_app/modules/track/track_screen.dart';
import 'package:apehipo_app/modules/transaction/transaction_controller.dart';
import 'package:apehipo_app/modules/transaction/transaction_model.dart';
import 'package:apehipo_app/widgets/confirmation_dialog_konfirmasi.dart';
import 'package:apehipo_app/widgets/success_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/LineSeparator.dart';
import 'package:apehipo_app/widgets/theme.dart';
import 'package:apehipo_app/widgets/app_text.dart';
import 'package:apehipo_app/widgets/colors.dart';

class TransactionWidget extends StatefulWidget {
  final Key key;
  List<TransactionModel> items;
  TransactionModel item;
  final String? heroSuffix;
  final VoidCallback? onAddPressed;

  TransactionWidget({
    required this.key,
    required this.item,
    required this.items,
    this.heroSuffix,
    this.onAddPressed,
  });

  @override
  State<TransactionWidget> createState() => _TransactionWidgetState();
}

class _TransactionWidgetState extends State<TransactionWidget> {
  final double width = 174;
  final Color borderColor = Color(0xffE2E2E2);
  final double borderRadius = 18;
  String status = "";
  String textStatus = "";
  String textButton = "";
  late IconData iconButton;
  late IconData iconDesc;

  @override
  void initState() {
    super.initState();
    status = widget.item.status;
    if (status == "sudah bayar") {
      iconButton = Icons.payment_outlined;
      iconDesc = Icons.payment_outlined;
      textStatus = "Pembeli telah membayar pesanan";
      textButton = "Proses Pesanan";
    } else if (status == "proses") {
      iconButton = Icons.directions_car_outlined;
      iconDesc = Icons.change_circle_outlined;
      textStatus = "Pesanan sedang anda proses";
      textButton = "Antar Pesanan";
    } else if (status == "antar") {
      iconButton = Icons.watch_later_rounded;
      iconDesc = Icons.credit_score_outlined;
      textStatus = "Pesanan sedang anda kirim";
      textButton = "Tunggu konfirmasi pembeli";
    } else {
      iconButton = Icons.watch_later_rounded;
      iconDesc = Icons.check_box_outlined;
      textStatus = "Pesanan anda telah diterima pembeli";
      textButton = "Tunggu konfirmasi pembeli";
    }
  }

  Widget getActionButton(BuildContext context, String label, String status,
      String idTransaksi, String idPenjual, String idPembeli, String idOrder,
      {Widget? trailingWidget}) {
    var controller = Get.put(TransactionController());
    var notificationController = Get.put(NotificationController());
    String pesan = "";
    String detailPesan = "";
    String idPengirim = idPenjual;
    String idPenerima = idPembeli;
    return Container(
      width: 150 * 2,
      height: 50,
      child: ElevatedButton(
        onPressed: status == "antar" || status == "selesai"
            ? null
            : () async {
                bool? confirmationResult = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    if (status == "sudah bayar") {
                      return ConfirmationDialogKonfirmasi(
                          message:
                              "Apakah anda yakin ingin mengonfirmasi pesanan?");
                    } else {
                      return ConfirmationDialogKonfirmasi(
                          message:
                              "Apakah anda yakin ingin mengantar pesanan?");
                    }
                  },
                );
                if (confirmationResult == true) {
                  String hasil = await controller.ubahData(status, idTransaksi);
                  print(hasil);
                  if (hasil == "proses") {
                    pesan = "Pesanan dengan id: " + idOrder;
                    detailPesan =
                        "Pesanan anda sedang diproses oleh penjual/toko";
                    notificationController.sendData(
                        pesan, detailPesan, idPenerima, idPengirim);
                    setState(() {
                      widget.item.status = "proses";
                      status = widget.item.status;
                    });
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SuccessConfirmationDialog(
                          message:
                              "Terima kasih! Anda telah mengonfirmasi pesanan",
                          icon: Icons.check_circle_outline,
                        );
                      },
                    );
                  } else if (hasil == "antar") {
                    pesan = "Pesanan dengan id: " + idOrder;
                    detailPesan =
                        "Pesanan anda sedang diantar oleh penjual/toko.";
                    notificationController.sendData(
                        pesan, detailPesan, idPenerima, idPengirim);
                    setState(() {
                      widget.item.status = "antar";
                      status = widget.item.status;
                    });
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SuccessConfirmationDialog(
                          message: "Terima kasih! Anda telah mengantar pesanan",
                          icon: Icons.directions_car_filled_outlined,
                        );
                      },
                    );
                  } else {
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SuccessConfirmationDialog(
                          message: "Mohon maaf! Terjadi kesalahan proses",
                          icon: Icons.close_outlined,
                        );
                      },
                    );
                  }
                } else {
                  print("gagal");
                }
              },
        style: ElevatedButton.styleFrom(
          visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 0,
          backgroundColor: status == "sudah bayar"
              ? AppColors.primaryColor
              : AppColors.darkGrey,
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
                  textButton,
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
                  iconButton,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
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
              height: 10,
            ),
            Row(
              children: [
                Icon(Icons.house_outlined),
                AppText(
                  text: "Alamat Lengkap: ",
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            AppText(
              text: widget.item.alamat,
              fontSize: 15,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(Icons.call_outlined),
                AppText(
                  text: "No Telpon: ",
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            AppText(
              text: widget.item.noTelpon,
              fontSize: 15,
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 1,
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
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (status == "sudah bayar" || status == "proses")
                  getActionButton(
                    context,
                    textButton,
                    widget.item.status,
                    widget.item.idTransaksi,
                    widget.item.idPenjual,
                    widget.item.idPembeli,
                    widget.item.idOrder,
                  ),
              ],
            )
          ],
        ),
      ),
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

Widget getTrackButton(BuildContext context, label, {Widget? trailingWidget}) {
  return Container(
    width: 150,
    height: 50,
    child: ElevatedButton(
      onPressed: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TrackScreen(),
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
                Icons.track_changes,
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
