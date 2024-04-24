import 'package:Apehipo/widgets/confirmation_dialog.dart';

import '../../controller/catalog_controller.dart';
import 'package:Apehipo/modules/catalog/model/catalog_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/LineSeparator.dart';
import 'package:Apehipo/widgets/theme.dart';
import 'package:Apehipo/widgets/app_text.dart';
import 'package:Apehipo/widgets/colors.dart';
import '../catalog_edit_screen.dart';

class CatalogItemWidget extends StatefulWidget {
  CatalogItemWidget({
    Key? key,
    required this.item,
    this.heroSuffix,
    this.onAddPressed,
  }) : super(key: key);

  final CatalogModel item;
  final String? heroSuffix;
  final VoidCallback? onAddPressed;

  @override
  State<CatalogItemWidget> createState() => _CatalogItemWidgetState();
}

class _CatalogItemWidgetState extends State<CatalogItemWidget> {
  final double width = 174;

  final double height = 220;

  final Color borderColor = Color(0xffE2E2E2);

  final double borderRadius = 18;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CatalogController());
    return Container(
      width: width,
      height: height,
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
            Row(children: [
              Hero(
                tag: "KatalogItem:" +
                    widget.item.nama +
                    "-" +
                    (widget.heroSuffix ?? ""),
                child: imageWidget(),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: widget.item.nama,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  AppText(
                    text: "Rp${widget.item.harga}",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              )),
              Padding(
                padding: EdgeInsets.all(8),
                child: InkWell(
                  onTap: () async {
                    bool? confirmationResult = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ConfirmationDialog(
                            message:
                                "Apakah anda yakin ingin menghapus produk?");
                      },
                    );
                    if (confirmationResult == true) {
                      controller.deleteData(widget.item.kode);
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
            ]),
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
            Row(
              children: [
                // Icon(Icons.layers_outlined, size: 14, color: Color(0xFF7C7C7C)),
                SizedBox(
                  width: 5,
                ),
                // AppText(
                //   text: "Stok: " + item.stok.toString(),
                //   fontSize: 14,
                //   fontWeight: FontWeight.w600,
                //   color: Color(0xFF7C7C7C),
                // ),
                SizedBox(
                  width: 150,
                ),
                // Icon(Icons.monetization_on_outlined,
                //     size: 14, color: Color(0xFF7C7C7C)),
                SizedBox(
                  width: 5,
                ),
                // AppText(
                //   text: "Terjual: 2",
                //   fontSize: 14,
                //   fontWeight: FontWeight.w600,
                //   color: Color(0xFF7C7C7C),
                // ),
              ],
            ),
            // SizedBox(
            //   height: 15,
            // ),
            // LineSeparator(
            //   height: 1,
            //   color: const Color.fromARGB(255, 211, 211, 211),
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                getEditButton(
                  "Edit Produk",
                  onPressed: () => onItemClicked(context, widget.item),
                ),
                SizedBox(
                  width: 20,
                ),
                getAction(context, "Publish", controller, widget.item)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget imageWidget() {
    return Container(
      child: Image.network(widget.item.foto),
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

Widget getEditButton(String label,
    {Widget? trailingWidget, required VoidCallback onPressed}) {
  return Container(
    width: 150,
    height: 50,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        elevation: 0,
        backgroundColor: Colors.amber,
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
                Icons.edit_note_outlined,
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

Widget getAction(BuildContext context, label, CatalogController controller,
    CatalogModel item,
    {Widget? trailingWidget}) {
  return Container(
    width: 150,
    height: 50,
    child: ElevatedButton(
      onPressed: () {
        controller.ubahStatus(item.kode, item.status);
      },
      style: ElevatedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        elevation: 0,
        backgroundColor: item.status == "tampil"
            ? AppColors.darkGrey
            : AppColors.primaryColor,
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
                label = item.status == "arsip"
                    ? label = "Publish"
                    : label = "Arsipkan",
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
                Icons.publish_outlined,
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

void onItemClicked(BuildContext context, CatalogModel catalogModel) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => CatalogEditScreen(
              catalogModel,
              heroSuffix: "account_katalog",
            )),
  );
}
