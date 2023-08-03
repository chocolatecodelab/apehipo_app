import 'dart:convert';

import 'package:apehipo_app/modules/home/models/dashboard_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../services/api.dart';

class DashboardController extends GetxController {
  List<DashboardModel>? dataList = [];
  var isLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    getAllData();
  }

  getAllData() async {
    try {
      isLoading(true);
      String baseUrl = '${Api().baseURL}/dashboard';
      print(baseUrl);
      final response = await http.get(Uri.tryParse(baseUrl)!);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        dataList = data.map((x) => DashboardModel.fromJson(x)).toList();
      } else {
        Get.snackbar("Pesan", "Terjadi kesalahan sistem");
      }
    } catch (e) {
      Get.snackbar("Kesalahan", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
