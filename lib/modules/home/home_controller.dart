import 'dart:convert';

import 'package:apehipo_app/modules/home/home_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../services/api.dart';

class HomeController extends GetxController {
  List<HomeModel>? dataListEksklusif = [];
  List<HomeModel>? dataListTerbaik = [];
  List<HomeModel>? dataListLaris = [];
  List<HomeModel>? dataList = [];
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
      final response = await http.get(Uri.tryParse(baseUrl)!);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> semuaProdukJsonList = data['semua_produk'];
        for (var item in semuaProdukJsonList) {
          HomeModel homeModel = HomeModel.fromJson(item);
          dataList!.add(homeModel);
        }
        List<dynamic> penjualanEksklusifJsonList = data['penjualan_eksklusif'];
        for (var item in penjualanEksklusifJsonList) {
          HomeModel homeModel = HomeModel.fromJson(item);
          dataListEksklusif!.add(homeModel);
        }
        List<dynamic> penjualanTerbaikJsonList = data['penjualan_terbaik'];
        for (var item in penjualanTerbaikJsonList) {
          HomeModel homeModel = HomeModel.fromJson(item);
          dataListTerbaik!.add(homeModel);
        }
        List<dynamic> sedangLarisJsonList = data['sedang_laris'];
        for (var item in sedangLarisJsonList) {
          HomeModel homeModel = HomeModel.fromJson(item);
          dataListLaris!.add(homeModel);
        }
        // for (var item in sedangLarisJsonList) {
        //   HomeModel homeModel = HomeModel.fromJson(item);
        //   dataList!.add(homeModel);
        // }
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
