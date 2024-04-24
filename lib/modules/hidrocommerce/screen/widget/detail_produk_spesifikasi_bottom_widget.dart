import 'package:flutter/material.dart';
import 'package:Apehipo/widgets/app_text.dart';

import '../../../order/screen/order_failed_screen.dart';

class SpesifikasiBottom extends StatefulWidget {
  final String? stok;
  final String? alamat;

  const SpesifikasiBottom(this.stok, this.alamat);
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

  Widget productDescription(stok) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            "Stok:",
            style: TextStyle(fontSize: 18),
          ),
          subtitle: AppText(
            text: widget.stok!,
            fontSize: 14,
            color: Color(0xff7C7C7C),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            "Dikirim dari:",
            style: TextStyle(fontSize: 18),
          ),
          subtitle: AppText(
            text: widget.alamat!,
            fontSize: 14,
            color: Color(0xff7C7C7C),
          ),
        ),
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
          return OrderFailedScreen();
        });
  }
}
