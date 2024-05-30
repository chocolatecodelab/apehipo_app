import 'dart:convert';

import 'package:Apehipo/modules/auth/controller/auth_controller.dart';
import 'package:Apehipo/modules/keloka_kebun/report/controller/report_controller.dart';
import 'package:Apehipo/modules/keloka_kebun/tanam/model/tanam_model.dart';
import 'package:Apehipo/services/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class TanamController extends GetxController {
  var controller = Get.put(ReportController());
  RxList<TanamModel>? dataTanamList = <TanamModel>[].obs;
  var isLoading = false.obs;
  late TextEditingController tanggal;
  late TextEditingController jumlah;
  late TextEditingController keterangan;
  late TextEditingController search;

  var auth = Get.put(AuthController());

  @override
  void onInit() {
    super.onInit();
    getAllData(auth.box.read("id_kebun"));
    tanggal = TextEditingController();
    jumlah = TextEditingController();
    keterangan = TextEditingController();
    search = TextEditingController();
  }

  getAllData(id) async {
    isLoading(true);
    try {
      String baseUrl = '${Api().baseURL}/tanam/$id';
      final response = await http.get(Uri.tryParse(baseUrl)!);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> dataTanamJsonList = data['data_tanam'];
        for (var item in dataTanamJsonList) {
          TanamModel tanamModel = TanamModel.fromJson(item);
          dataTanamList!.add(tanamModel);
        }
      }
    } catch (e) {
      print("Catch $e");
    } finally {
      isLoading(false);
    }
  }

  Future refresh() async {
    try {
      isLoading(true);
      String baseUrl = '${Api().baseURL}/tanam';
      final response = await http.get(Uri.tryParse(baseUrl)!);
      if (response.statusCode == 200) {
        dataTanamList!.clear();
        dataTanamList!.clear();
      }
    } catch (e) {
    } finally {
      isLoading(true);
      getAllData(auth.box.read("id_kebun"));
    }
  }

  Future getSearch() async {
    try {
      isLoading(true);
      var map = <String, dynamic>{};
      map['keyword'] = search.text;
      map['id_kebun'] = auth.box.read("id_kebun");
      String baseUrl = '${Api().baseURL}/tanam/search';
      var request = http.MultipartRequest('POST', Uri.tryParse(baseUrl)!);
      map.forEach((key, value) {
        request.fields[key] = value;
      });
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await http.Response.fromStream(response);
        dataTanamList!.clear();
        var responjson = jsonDecode(responseBody.body);
        print(responjson);
        Map<String, dynamic> data = jsonDecode(responseBody.body);
        print(data);
        List<dynamic> hasilSearchJsonList = data['hasil_search'];
        if (hasilSearchJsonList.isEmpty) {
          // getAllData(auth.box.read("id_kebun"));
          return "gagal";
        }
        for (var item in hasilSearchJsonList) {
          TanamModel tanamModel = TanamModel.fromJson(item);
          dataTanamList!.add(tanamModel);
        }
        return "sukses";
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      return "gagal";
    } finally {
      isLoading(false);
    }
  }

  Future toPanen(id) async {
    try {
      var map = <String, dynamic>{};
      map['tanggal_panen'] = tanggal.text;
      map['jumlah_panen'] = jumlah.text;
      map['keterangan'] = keterangan.text;
      print(map);
      if (tanggal.text == "" || jumlah.text == "" || keterangan.text == "") {
        return "gagal";
      }
      String baseUrl = '${Api().baseURL}/tanam/toPanen/$id';
      var request = http.MultipartRequest('POST', Uri.tryParse(baseUrl)!);
      map.forEach((key, value) {
        request.fields[key] = value;
      });
      print(map);
      var response = await request.send();
      if (response.statusCode == 200) {
        print(response.statusCode);
        controller.refresh();
        refresh();
        return "sukses";
      } else {
        print(response.statusCode);
        return "gagal";
      }
    } catch (e) {
      print(e);
      return "gagal";
    } finally {
      clearData();
    }
  }

  void clearData() {
    tanggal.text = "";
    jumlah.text = "";
    keterangan.text = "";
  }
}
