import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'product_controller.dart';

class ProductUbah extends StatefulWidget {
  final String kode;
  final String produk;
  const ProductUbah(this.kode, this.produk);

  @override
  State<ProductUbah> createState() => _ProductUbahState();
}

class _ProductUbahState extends State<ProductUbah> {
  var controller = Get.put(ProductController());
  final formFieldKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller.kode.text = widget.kode;
    controller.nama.text = widget.produk;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Form(
              key: formFieldKey,
              child: Column(
                children: [
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  //   child: TextFormField(
                  //     controller: controller.kode,
                  //     decoration: InputDecoration(
                  //         border: UnderlineInputBorder(),
                  //         labelText: "kode produk"),
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: controller.nama,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "nama produk"),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        controller.updateData(widget.kode);
                      },
                      child: Text("Kirim")),
                ],
              ))
        ],
      )),
    );
    ;
  }
}
