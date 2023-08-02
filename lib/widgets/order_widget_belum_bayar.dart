import 'package:apehipo_app/modules/payment/payment_screen.dart';
import 'package:apehipo_app/widgets/app_button.dart';
import 'package:apehipo_app/widgets/confirmation_dialog_batal.dart';
import 'package:flutter/material.dart';
import 'LineSeparator.dart';
import 'package:apehipo_app/widgets/theme.dart';
import 'package:apehipo_app/widgets/app_text.dart';
import 'package:apehipo_app/modules/account/models/katalog_item.dart';
import 'package:apehipo_app/widgets/colors.dart';
import 'package:apehipo_app/modules/account/catalog_details.dart';
import '.././widgets/confirmation_dialog.dart';

class OrderBelumBayarWidget extends StatelessWidget {
  OrderBelumBayarWidget({
    Key? key,
    required this.item,
    this.heroSuffix,
    this.onAddPressed,
  }) : super(key: key);

  final KatalogItem item;
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
                tag: "KatalogItem:" + item.name + "-" + (heroSuffix ?? ""),
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
                    text: item.name,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  AppText(
                    text: "x2",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  AppText(
                    text: "\$${item.price.toStringAsFixed(2)}",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              )),
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
            AppText(
              text: "Batas akhir pembayaran: 12 Agustus 2023",
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 15,),
            AppText(
              text: "Total: \$${item.price.toString()}",
              textAlign: TextAlign.right,
              fontWeight: FontWeight.bold, 
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                getCancelButton(
                  context,
                  "Batalkan",
                ),
                SizedBox(
                  width: 20,
                ),
                getBayarButton(context, "Bayar")
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget imageWidget() {
    return Container(
      child: Image.asset(item.imagePath),
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

Widget getCancelButton(BuildContext context, label, {Widget? trailingWidget}) {
  return Container(
    width: 150,
    height: 50,
    child: ElevatedButton(
      onPressed: () async {
      bool? confirmationResult = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmationDialogBatal(
              message: "Apakah anda yakin ingin membatalkan pesanan?"
          );
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

Widget getBayarButton(BuildContext context, label, {Widget? trailingWidget}) {
  return Container(
    width: 150,
    height: 50,
    child: ElevatedButton(
      onPressed: () => {
        Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) => PaymentScreen(),
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

void onItemClicked(BuildContext context, KatalogItem katalogItem) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => CatalogDetailsScreen(
              katalogItem,
              heroSuffix: "account_katalog",
            )),
  );
}

