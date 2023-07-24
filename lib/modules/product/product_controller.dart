import 'dart:convert';

import 'package:apehipo_app/modules/product/product_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../services/api.dart';

class ProductController extends GetxController {
  List<ProductModel> data = [];

  @override
  Future<void> onInit() async {
    super.onInit();
    getAllData();
  }

  getAllData() async {
    try {
      String baseUrl = '${Api().baseURL}products/1';
      final response = await http.get(Uri.tryParse(baseUrl)!);
      if (response.statusCode == 200) {
        List result = jsonDecode(response.body);
        data = result.map((data) => ProductModel.fromJson(data)).toList();
        Get.snackbar("Pesan", response.body.toString());
      } else {
        Get.snackbar("Pesan", "Data error");
      }
    } catch (e) {
      Get.snackbar("Pesan", "Data error");
    }
  }
}
