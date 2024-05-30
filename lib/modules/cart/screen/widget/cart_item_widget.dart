import 'package:Apehipo/modules/cart/controller/cart_controller.dart';
import 'package:Apehipo/modules/cart/model/cart_model.dart';
import 'package:Apehipo/modules/cart/screen/cart_change.dart';
import 'package:flutter/material.dart';
import 'package:Apehipo/widgets/app_text.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    final cart = Provider.of<CartChange>(context);
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
                SizedBox(
                  height: 25,
                ),
                AppText(
                  text: widget.item.nama,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 12,
                ),
                // Spacer(),
                Container(
                  width: 80,
                  child: AppText(
                    text: "Rp${getPrice().toStringAsFixed(0)}",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () async {
                    String hasil = await controller.deleteData(
                        widget.item.id, widget.item.amount);
                    if (hasil == "sukses") {
                      cart.incrementCounter(controller.dataList!.length);
                    }
                    // Tindakan yang ingin dilakukan saat tombol ditekan
                  },
                  icon: Icon(Icons.close),
                ),
                Spacer(
                  flex: 5,
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
    return InkWell(
      onTap: () {
        // Tambahkan aksi yang ingin dilakukan saat gambar diklik di sini.
      },
      child: Container(
        width: 100,
        child: Image.network(widget.item.foto),
      ),
    );
  }

  double getPrice() {
    double harga = double.parse(widget.item.harga);
    return harga * widget.item.amount;
  }
}
