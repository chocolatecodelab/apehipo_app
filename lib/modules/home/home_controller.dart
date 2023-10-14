import 'dart:convert';

import 'package:Apehipo/modules/home/home_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../services/api.dart';

class HomeController extends GetxController {
  RxList<HomeModel>? dataListBuah = <HomeModel>[].obs;
  RxList<HomeModel>? dataListSayuran = <HomeModel>[].obs;
  RxList<HomeModel>? dataList = <HomeModel>[].obs;

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
