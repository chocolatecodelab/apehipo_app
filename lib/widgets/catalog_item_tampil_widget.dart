import 'package:apehipo_app/modules/catalog/catalog_model.dart';
import 'package:apehipo_app/widgets/confirmation_dialog_arsip.dart';
import 'package:apehipo_app/widgets/delete_confirmation_dialog.dart';
import '../widgets/success_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'LineSeparator.dart';
import 'package:apehipo_app/widgets/theme.dart';
import 'package:apehipo_app/widgets/app_text.dart';
import 'package:apehipo_app/modules/account/models/katalog_item.dart';
import 'package:apehipo_app/widgets/colors.dart';
import '../modules/catalog/catalog_edit.dart';

class CatalogItemTampilWidget extends StatelessWidget {
  CatalogItemTampilWidget({
    Key? key,
    required this.item,
    this.heroSuffix,
    this.onAddPressed,
  }) : super(key: key);

  final CatalogModel item;
  final String? heroSuffix;
  final VoidCallback? onAddPressed;

  final double width = 174;
  final double height = 300;
  final Color borderColor = Color(0xffE2E2E2);
  final double borderRadius = 18;

  @override
  Widget build(BuildContext context) {
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
                tag: "KatalogItem:" + item.nama + "-" + (heroSuffix ?? ""),
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
                    text: item.nama,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  AppText(
                    text: "\$${item.harga}",
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
                        return DeleteConfirmationDialog(
                            message:
                                "Apakah anda yakin ingin menghapus produk?");
                      },
                    );
                    if (confirmationResult == true) {
                      SuccessConfirmationDialog(
                        message: "Anda berhasil menyimpan perubahan",
                        icon: Icons.check_circle_outline,
                      );
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
                Icon(
                  Icons.favorite_border_outlined,
                  color: Color(0xFF7C7C7C),
                  size: 14,
                ),
                SizedBox(
                  width: 5,
                ),
                AppText(
                  text: "Terjual: 2",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF7C7C7C),
                ),
                SizedBox(
                  width: 150,
                ),
                Icon(
                  Icons.layers_outlined,
                  color: Color(0xFF7C7C7C),
                  size: 14,
                ),
                SizedBox(
                  width: 5,
                ),
                AppText(
                  text: "Stok: " + item.stok.toString(),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF7C7C7C),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
                // children: [
                //   Icon(Icons.remove_red_eye_outlined,
                //       size: 14, color: Color(0xFF7C7C7C)),
                //   SizedBox(
                //     width: 5,
                //   ),
                //   AppText(
                //     text: "Dilihat: " + item.dilihat.toString(),
                //     fontSize: 14,
                //     fontWeight: FontWeight.w600,
                //     color: Color(0xFF7C7C7C),
                //   ),
                //   SizedBox(
                //     width: 150,
                //   ),
                //   Icon(Icons.monetization_on_outlined,
                //       size: 14, color: Color(0xFF7C7C7C)),
                //   SizedBox(
                //     width: 5,
                //   ),
                //   AppText(
                //     text: "Terjual: " + item.sold.toString(),
                //     fontSize: 14,
                //     fontWeight: FontWeight.w600,
                //     color: Color(0xFF7C7C7C),
                //   ),
                // ],
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                getEditButton(
                  "Edit Produk",
                  onPressed: () => onItemClicked(context, item),
                ),
                SizedBox(
                  width: 20,
                ),
                getArsipButton(context, "Arsipkan")
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget imageWidget() {
    return Container(
      child: Image.network(item.foto),
      width: 100,
      height: 100,
    );
  }

  Widget editWidget() {
    return GestureDetector(
      onTap: onAddPressed,
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

Widget getArsipButton(BuildContext context, label, {Widget? trailingWidget}) {
  return Container(
    width: 150,
    height: 50,
    child: ElevatedButton(
      onPressed: () async {
        bool? confirmationResult = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return ConfirmationDialogArsip(
                message: "Apakah anda yakin ingin mengarsipkan produk #?");
          },
        );
        if (confirmationResult == true) {
          print("Hello");
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
        backgroundColor: Colors.grey,
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
                Icons.archive_outlined,
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

void onItemClicked(BuildContext context, CatalogModel catalogItem) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => CatalogEditScreen(
              catalogItem,
              heroSuffix: "account_katalog",
            )),
  );
}
