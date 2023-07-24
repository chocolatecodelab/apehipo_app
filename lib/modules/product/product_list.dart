import 'product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    var data = controller.getAllData();
    return Scaffold(
      body: Column(
        children: [Text(data.toString()), Text("Mantap"), Text("Sukses")],
      ),
    );
  }
}
