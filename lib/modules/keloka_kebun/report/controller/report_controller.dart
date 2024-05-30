import 'dart:convert';

import 'package:Apehipo/modules/auth/controller/auth_controller.dart';
import 'package:Apehipo/modules/keloka_kebun/report/model/data_sayur_model.dart';
import 'package:Apehipo/modules/keloka_kebun/report/model/report_model.dart';
import 'package:Apehipo/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ReportController extends GetxController {
  RxList<DataSayurModel>? dataSayurList = <DataSayurModel>[].obs;
  var report = ReportModel(
    totalSayurDisemai: 0,
    totalSayurDitanam: 0,
    totalSayurDipanen: 0,
    jumlahSayur: 0,
  ).obs;
  var isLoading = false.obs;

  var auth = Get.put(AuthController());
  Future<void> onInit() async {
    super.onInit();
    getAllData(auth.box.read("id_kebun"));
  }

  getAllData(id) async {
    isLoading(true);
    try {
      String baseUrl = '${Api().baseURL}/report/$id';
      final response = await http.get(Uri.tryParse(baseUrl)!);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        report.value = ReportModel.fromJson(responseBody['report']);
        List<dynamic> dataSayurJsonList = responseBody['data_sayur'];
        for (var item in dataSayurJsonList) {
          DataSayurModel dataSayurModel = DataSayurModel.fromJson(item);
          dataSayurList!.add(dataSayurModel);
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
      String baseUrl = '${Api().baseURL}/report';
      final response = await http.get(Uri.tryParse(baseUrl)!);
      if (response.statusCode == 200) {
        dataSayurList!.clear();
      }
    } catch (e) {
    } finally {
      isLoading(true);
      getAllData(auth.box.read("id_kebun"));
    }
  }
}
