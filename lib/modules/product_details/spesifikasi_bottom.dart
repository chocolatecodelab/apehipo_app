import 'package:flutter/material.dart';
import 'package:apehipo_app/widgets/app_button.dart';
import 'package:apehipo_app/widgets/app_text.dart';

import '../order/order_failed_dialog.dart';

class SpesifikasiBottom extends StatefulWidget {
  final String? stok;

  const SpesifikasiBottom(this.stok);
  @override
  _SpesifikasiBottomState createState() => _SpesifikasiBottomState();
}

class _SpesifikasiBottomState extends State<SpesifikasiBottom> {
  @override
  Widget build(BuildContext context) {
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
                text: "Spesifikasi",
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
          Divider(),
          productDescription(widget.stok),
          SizedBox(
            height: 45,
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
          text: 'By placing an order you agree to our',
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
            TextSpan(text: " And"),
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

  Widget productDescription(stok) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 80,
              child: AppText(
                text: "Stok",
                fontSize: 18,
              ),
            ),
            SizedBox(
              width: 100,
            ), // Gunakan nilai labelWidth untuk lebar label
            AppText(text: stok, fontSize: 18),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Container(
              width: 120,
              child: AppText(
                text: "Dikirim dari ",
                fontSize: 18,
              ),
            ),
            AppText(text: "Kabupaten Banjarbaru", fontSize: 18),
          ],
        ),

        // ListTile(
        //   contentPadding: EdgeInsets.zero,
        //   title: Text(
        //     "Stok: ",
        //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
        //   ),
        //   subtitle: AppText(
        //     text: stok,
        //     fontSize: 16,
        //     fontWeight: FontWeight.w600,
        //     color: Color(0xff7C7C7C),
        //   ),
        //   // trailing: Icon(icons),
        // ),
      ],
    );
  }

  Widget checkoutRow(String label,
      {String? trailingText, Widget? trailingWidget}) {
    return Container(
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
            Icons.arrow_forward_ios,
            size: 20,
          )
        ],
      ),
    );
  }

  void onPlaceOrderClicked() {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return OrderFailedDialogue();
        });
  }
}
