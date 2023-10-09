import 'dart:convert';
import 'dart:io';

import 'package:apehipo_app/auth/auth_controller.dart';
import 'package:apehipo_app/modules/order/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../services/api.dart';

class OrderController extends GetxController {
  List<OrderModel>? dataBelumList = [];
  List<OrderModel>? dataSudahList = [];
  List<OrderModel>? dataBatalList = [];
  var isLoading = false.obs;
  @override
  var auth = Get.put(AuthController());
  Future<void> onInit() async {
    super.onInit();
    getAllData(auth.box.read('id_user'));
  }

  Future getAllData(id) async {
    try {
      isLoading(true);
      String baseUrl = '${Api().baseURL}/order/$id';
      final response = await http.get(Uri.tryParse(baseUrl)!);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> dataBelumJsonList = data['belum_bayar'];
        for (var item in dataBelumJsonList) {
          OrderModel orderModel = OrderModel.fromJson(item);
          dataBelumList!.add(orderModel);
        }

        List<dynamic> dataSudahJsonList = data['sudah_bayar'];
        for (var item in dataSudahJsonList) {
          OrderModel orderModel = OrderModel.fromJson(item);
          dataSudahList!.add(orderModel);
        }

        List<dynamic> dataBatalJsonList = data['dibatalkan'];
        for (var item in dataBatalJsonList) {
          OrderModel orderModel = OrderModel.fromJson(item);
          dataBatalList!.add(orderModel);
        }
      }
    } catch (e) {
      Get.snackbar("Kesalahan", e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future refresh() async {
    try {
      isLoading(true);
      dataBatalList!.clear();
      dataBelumList!.clear();
      dataSudahList!.clear();
    } catch (e) {
    } finally {
      isLoading(true);
      getAllData(auth.box.read("id_user"));
    }
  }

  ubahStatus(id, status) async {
    try {
      isLoading(true);
      var map = <String, dynamic>{};
      map['status'] = status;
      String baseUrl = '${Api().baseURL}/order/status/$id';
      final response = await http.post(Uri.tryParse(baseUrl)!, body: map);
      print(response.statusCode);
      if (response.statusCode == 200) {}
    } catch (e) {
    } finally {
      isLoading(false);
      refresh();
    }
  }
}
