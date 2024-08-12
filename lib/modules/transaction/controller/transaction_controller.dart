import 'dart:convert';

import '../../auth/controller/auth_controller.dart';
import '../model/transaction_model.dart';
import '../../../services/api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TransactionController extends GetxController {
  List<TransactionModel>? dataProsesList = [];
  List<TransactionModel>? dataSelesaiList = [];
  var isLoading = false.obs;

  var auth = Get.put(AuthController());
  Future<void> onInit() async {
    super.onInit();
    getAllData(auth.box.read("id_user"));
  }

  Future getAllData(id) async {
    try {
      isLoading(true);
      String baseUrl = '${Api().baseURL}/transaksi/$id';
      final response = await http.get(Uri.tryParse(baseUrl)!);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> dataProsesJsonList = data['proses_bayar'];
        for (var item in dataProsesJsonList) {
          TransactionModel transactionModel = TransactionModel.fromJson(item);
          dataProsesList!.add(transactionModel);
        }
        List<dynamic> dataSelesaiJsonList = data['selesai'];
        for (var item in dataSelesaiJsonList) {
          TransactionModel transactionModel = TransactionModel.fromJson(item);
          dataSelesaiList!.add(transactionModel);
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
      dataProsesList!.clear();
      dataSelesaiList!.clear();
    } catch (e) {
    } finally {
      isLoading(false);
      getAllData(auth.box.read("id_user"));
    }
  }

  Future<String> ubahData(String status, String idTransaksi) async {
    try {
      isLoading(true);
      String statusTransaksi = "";
      var map = <String, dynamic>{};
      if (status == "sudah bayar") {
        statusTransaksi = "proses";
      } else if (status == "proses") {
        statusTransaksi = "antar";
      }
      // map untuk status tbl_transaksi
      map['status'] = statusTransaksi;
      String baseUrl = '${Api().baseURL}/transaksi/status/$idTransaksi';
      final response = await http.post(Uri.tryParse(baseUrl)!, body: map);
      if (response.statusCode == 200) {
        if (status == "sudah bayar") {
          return "proses";
        } else {
          return "antar";
        }
      } else {
        return "gagal";
      }
    } catch (e) {
      return "gagal";
    } finally {
      refresh();
    }
  }
}
