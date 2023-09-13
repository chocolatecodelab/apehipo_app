import 'package:apehipo_app/auth/auth_controller.dart';
import 'package:apehipo_app/modules/address/address_bottom_sheet.dart';
import 'package:apehipo_app/modules/address/address_screen.dart';
import 'package:apehipo_app/modules/cart/cart_controller.dart';
import 'package:apehipo_app/modules/cart/cart_screen.dart';
// import 'package:apehipo_app/modules/order/order_screen.dart';
import 'package:apehipo_app/modules/payment/payment_page.dart';
import 'package:apehipo_app/screens/order_accepted_screen.dart';
import 'package:apehipo_app/widgets/success_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:apehipo_app/widgets/app_button.dart';
import 'package:apehipo_app/widgets/app_text.dart';
import 'package:get/get.dart';
import '../../screens/order_failed_dialog.dart';

class CheckoutBottomSheet extends StatefulWidget {
  final String totalHarga;

  const CheckoutBottomSheet(this.totalHarga);
  @override
  _CheckoutBottomSheetState createState() => _CheckoutBottomSheetState();
}

class _CheckoutBottomSheetState extends State<CheckoutBottomSheet> {
  @override
  var auth = Get.put(AuthController());
  var controller = Get.put(CartController());
  Widget build(BuildContext context) {
    double jumlahHarga = double.parse(widget.totalHarga) + 1000;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 30,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: new Wrap(
        children: <Widget>[
          Row(
            children: [
              AppText(
                text: "Check Out",
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              Spacer(),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    size: 25,
                  ))
            ],
          ),
          SizedBox(
            height: 45,
          ),
          getDivider(),
          checkoutRow("Alamat", trailingText: "Alamat Saya"),
          getDivider(),
          checkoutRow("Biaya Administrasi", trailingText: "Rp1000"),
          getDivider(),
          checkoutRow("Total Pembelian",
              trailingText: "Rp${jumlahHarga.toStringAsFixed(0)}"),
          getDivider(),
          SizedBox(
            height: 30,
          ),
          termsAndConditionsAgreement(context),
          Container(
            margin: EdgeInsets.only(
              top: 25,
            ),
            child: AppButton(
              label: "Buat Pesanan",
              // fontWeight: FontWeight.w600,
              padding: EdgeInsets.symmetric(
                vertical: 25,
              ),
              onPressed: () async {
                String? hasil = await controller.sendData(
                    jumlahHarga, auth.box.read("id_user"));
                onPlaceOrderClicked(jumlahHarga, hasil);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getDivider() {
    return Divider(
      thickness: 1,
      color: Color(0xFFE2E2E2),
    );
  }

  Widget termsAndConditionsAgreement(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: 'Dengan melakukan pemesanan, Anda setuju dengan',
          style: TextStyle(
            color: Color(0xFF7C7C7C),
            fontSize: 14,
            fontFamily: Theme.of(context).textTheme.bodyText1?.fontFamily,
            fontWeight: FontWeight.w600,
          ),
          children: [
            TextSpan(
              text: " Terms",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            TextSpan(text: " dan"),
            TextSpan(
              text: " Conditions",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
    );
  }

  void showBottomSheets(context, {String? key, String? value}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          if (key == "payment") {
            return PaymentPage(value);
          } else if (key == "alamat") {
            return AddressBottom();
          }
          return SizedBox.shrink();
        });
  }

  Widget checkoutRow(String label,
      {String? trailingText, Widget? trailingWidget, String? value}) {
    bool icon;
    if (label == "Biaya Administrasi" || label == "Total Pembelian") {
      icon = true;
    } else {
      icon = false;
    }
    return InkWell(
      onTap: () => {
        if (label == "Metode")
          {showBottomSheets(context, key: "delivery", value: value)}
        else if (label == "Pembayaran")
          {
            showBottomSheets(context, key: "payment"),
          }
        else if (label == "Alamat")
          {showBottomSheets(context, key: "alamat")}
        // else if (label == "Total Pembelian")
        //   {
        //     Navigator.of(context).pushReplacement(new MaterialPageRoute(
        //       builder: (BuildContext context) {
        //         return CartScreen();
        //       },
        //     )),
        //   }
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 15,
        ),
        child: Row(
          children: [
            AppText(
              text: label,
              fontSize: 18,
              color: Color(0xFF7C7C7C),
              fontWeight: FontWeight.w600,
            ),
            Spacer(),
            trailingText == null
                ? (trailingWidget ?? Container())
                : AppText(
                    text: trailingText,
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
            SizedBox(
              width: 20,
            ),
            Icon(
              icon == true
                  ? Icons.arrow_right_rounded
                  : Icons.arrow_forward_ios,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void onPlaceOrderClicked(double jumlahHarga, String hasil) {
    if (hasil == "sukses") {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return OrderAcceptedScreen();
          });
    } else {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return SuccessConfirmationDialog(
                message: "Anda gagal menambahkan pesanan",
                icon: Icons.close_rounded);
          });
    }
  }
}
