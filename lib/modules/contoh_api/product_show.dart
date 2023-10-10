import 'package:apehipo_app/modules/contoh_api/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class ProductShow extends StatelessWidget {
  final String id;
  final String produk;
  const ProductShow(this.id, this.produk);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() => controller.isLoading.value
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()))
              : this.id.isEmpty
                  ? const Expanded(
                      child: Center(child: Text("Tidak ada data.")))
                  : Column(
                      children: [Text(this.id), Text(this.produk)],
                    ))
        ],
      )),
    );
  }
}
