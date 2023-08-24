import 'package:apehipo_app/modules/cart/cart_controller.dart';
import 'package:apehipo_app/modules/cart/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:apehipo_app/widgets/app_text.dart';
import 'package:apehipo_app/modules/home/models/grocery_item.dart';
import 'package:apehipo_app/widgets/colors.dart';
import 'package:get/get.dart';

import 'item_counter_widget.dart';

class ChartItemWidget extends StatefulWidget {
  ChartItemWidget({Key? key, required this.item}) : super(key: key);
  final CartModel item;

  @override
  _ChartItemWidgetState createState() => _ChartItemWidgetState();
}

class _ChartItemWidgetState extends State<ChartItemWidget> {
  final double height = 110;

  final Color borderColor = Color(0xffE2E2E2);

  final double borderRadius = 18;

  int amount = 1;

  @override
  var controller = Get.put(CartController());
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(
        vertical: 30,
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            imageWidget(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: widget.item.nama,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 5,
                ),
                // AppText(
                //     text: widget.item.description,
                //     fontSize: 14,
                //     fontWeight: FontWeight.bold,
                //     color: AppColors.darkGrey),
                SizedBox(
                  height: 12,
                ),
                Spacer(),
                ItemCounterWidget(
                  onAmountChanged: (newAmount) {
                    setState(() {
                      amount = newAmount;
                    });
                  },
                )
              ],
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    controller.deleteData(widget.item.id);
                    // Tindakan yang ingin dilakukan saat tombol ditekan
                  },
                  icon: Icon(Icons.close),
                ),
                Spacer(
                  flex: 5,
                ),
                Container(
                  width: 70,
                  child: AppText(
                    text: "\$${getPrice().toStringAsFixed(2)}",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.right,
                  ),
                ),
                Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget imageWidget() {
    return Container(
      width: 100,
      child: Image.asset(widget.item.foto),
    );
  }

  double getPrice() {
    double harga = double.parse(widget.item.harga);
    return harga * amount;
  }
}
