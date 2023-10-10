import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'product_controller.dart';

class ProductAdd extends StatelessWidget {
  const ProductAdd({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    final formFieldKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Form(
              key: formFieldKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: controller.kode,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "kode produk"),
                    ),
                  ),
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
                        controller.sendData();
                      },
                      child: Text("Kirim")),
                ],
              ))
        ],
      )),
    );
  }
}
