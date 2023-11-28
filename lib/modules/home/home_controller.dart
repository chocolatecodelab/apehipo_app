import 'dart:convert';

import 'package:Apehipo/modules/home/home_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../services/api.dart';

class HomeController extends GetxController {
  List<HomeModel>? dataListBuah = <HomeModel>[].obs;
  List<HomeModel>? dataListSayuran = <HomeModel>[].obs;
  List<HomeModel>? dataList = <HomeModel>[].obs;
  RxList<HomeModel>? dataSearch = <HomeModel>[].obs;
  late TextEditingController search;
  var isLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    getAllData();
    search = TextEditingController();
  }

  getAllData() async {
    try {
      isLoading(true);
      String baseUrl = '${Api().baseURL}/dashboard';
      final response = await http.get(Uri.tryParse(baseUrl)!);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> semuaProdukJsonList = data['semua_produk'];
        for (var item in semuaProdukJsonList) {
          HomeModel homeModel = HomeModel.fromJson(item);
          dataList!.add(homeModel);
        }
        List<dynamic> dataBuahJsonList = data['buah'];
        for (var item in dataBuahJsonList) {
          HomeModel homeModel = HomeModel.fromJson(item);
          dataListBuah!.add(homeModel);
        }
        List<dynamic> dataSayurJsonList = data['sayuran'];
        for (var item in dataSayurJsonList) {
          HomeModel homeModel = HomeModel.fromJson(item);
          dataListSayuran!.add(homeModel);
        }
      } else {}
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }

  Future<String> getSpesifikData(String keyword) async {
    try {
      print(keyword);
      if (keyword == "") {
        isLoading(true);
        refresh();
      } else {
        isLoading(true);
        String baseUrl = '${Api().baseURL}/dashboard/cari/$keyword';
        final response = await http.post(Uri.tryParse(baseUrl)!);
        print(response.statusCode);
        // print(response.body);
        if (response.statusCode == 200) {
          dataList!.clear();
          Map<String, dynamic> data = jsonDecode(response.body);
          List<dynamic> produkSearchJsonList = data['produk_search'];
          for (var item in produkSearchJsonList) {
            HomeModel homeModel = HomeModel.fromJson(item);
            dataList!.add(homeModel);
          }
          return "sukses";
        }
      }

      return "gagal";
    } catch (e) {
      Get.snackbar("kesalahan", e.toString());
      return "gagal";
    } finally {
      isLoading(false);
    }
  }

  Future refresh() async {
    try {
      isLoading(true);
      dataList!.clear();
      dataListBuah!.clear();
      dataListSayuran!.clear();
    } catch (e) {
    } finally {
      isLoading(true);
      getAllData();
    }
  }
}
