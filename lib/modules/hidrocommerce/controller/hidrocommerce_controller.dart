import 'dart:convert';

import 'package:Apehipo/modules/hidrocommerce/model/hidrocommerce_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../services/api.dart';

class HidrocommerceController extends GetxController {
  List<HidrocommerceModel>? dataListBuah = <HidrocommerceModel>[].obs;
  List<HidrocommerceModel>? dataListSayuran = <HidrocommerceModel>[].obs;
  List<HidrocommerceModel>? dataList = <HidrocommerceModel>[].obs;
  RxList<HidrocommerceModel>? dataSearch = <HidrocommerceModel>[].obs;
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
          HidrocommerceModel hidrocommerceModel =
              HidrocommerceModel.fromJson(item);
          dataList!.add(hidrocommerceModel);
        }
        List<dynamic> dataBuahJsonList = data['buah'];
        for (var item in dataBuahJsonList) {
          HidrocommerceModel hidrocommerceModel =
              HidrocommerceModel.fromJson(item);
          dataListBuah!.add(hidrocommerceModel);
        }
        List<dynamic> dataSayurJsonList = data['sayuran'];
        for (var item in dataSayurJsonList) {
          HidrocommerceModel hidrocommerceModel =
              HidrocommerceModel.fromJson(item);
          dataListSayuran!.add(hidrocommerceModel);
        }
      } else {}
    } catch (e) {
    } finally {
      await Future.delayed(Duration(seconds: 1));
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
          if (produkSearchJsonList.isEmpty) {
            getAllData();
            return "gagal";
          }
          for (var item in produkSearchJsonList) {
            HidrocommerceModel hidrocommerceModel =
                HidrocommerceModel.fromJson(item);
            dataList!.add(hidrocommerceModel);
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
