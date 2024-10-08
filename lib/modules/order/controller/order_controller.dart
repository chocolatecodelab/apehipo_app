import 'dart:convert';

import 'package:Apehipo/modules/auth/controller/auth_controller.dart';
import 'package:Apehipo/modules/order/model/order_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../../services/api.dart';

class OrderController extends GetxController {
  List<OrderModel>? dataBelumList = [];
  List<OrderModel>? dataSudahList = [];
  List<OrderModel>? dataBatalList = [];
  var isLoading = false.obs;
  var auth = Get.put(AuthController());
  Future<void> onInit() async {
    super.onInit();
    getAllData(auth.box.read('id_user'));
  }

  Future getAllData(id) async {
    try {
      isLoading(true);
      String baseUrl = "";
      if (auth.box.read("role") == "admin") {
        baseUrl = '${Api().baseURL}/order';
      } else {
        baseUrl = '${Api().baseURL}/order/$id';
      }
      final response = await http.get(Uri.tryParse(baseUrl)!);
      if (response.statusCode == 200) {
        print(response.statusCode);
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
      // Get.snackbar("Kesalahan", e.toString());
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

  Future<bool> ubahStatus(
      String? idOrder, String totalHarga, String status, String idUser) async {
    try {
      List<Map<String, dynamic>> orderModelList = [];
      for (var orderModel in dataBelumList!) {
        orderModelList.add(orderModel.toJson());
      }
      print(status);
      String statusTransaksi = "";
      if (status == "belum bayar") {
        status = "sudah bayar";
        statusTransaksi = "sudah bayar";
      } else if (status == "sudah bayar") {
        statusTransaksi = "selesai";
      }
      isLoading(true);
      var map = <String, dynamic>{};
      // map untuk tbl_order
      map['status'] = status;
      String baseUrl = '${Api().baseURL}/order/status/$idOrder';
      final response = await http.post(Uri.tryParse(baseUrl)!, body: map);
      if (response.statusCode == 200) {
        print(response.statusCode);
        if (statusTransaksi == "selesai") {
          map['status'] = statusTransaksi;
          String baseUrl = '${Api().baseURL}/transaksi/status/$idOrder';
          final response = await http.post(Uri.tryParse(baseUrl)!, body: map);
          if (response.statusCode == 200) {
            print(response.statusCode);
          }
        } else {
          String baseUrl = '${Api().baseURL}/transaksi';
          // map untuk tbl_transaksi
          map['id_order'] = idOrder;
          map['total_harga_produk'] = totalHarga;
          map['status_transaksi'] = statusTransaksi;
          map['id_user'] = idUser;
          //map untuk detail_transaksi
          map['data_produk'] = orderModelList;
          String data = jsonEncode(map);
          print(data);
          final response2 = await http.post(Uri.tryParse(baseUrl)!, body: data);
          if (response2.statusCode == 200) {
            print(response2.statusCode);
          }
        }
      } else {
        print("gagal");
      }
      return true;
    } catch (e) {
      return false;
    } finally {
      refresh();
    }
  }

  Future<String> kirimBukti(String id, XFile? image) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.tryParse('${Api().baseURL}/order/bukti/$id')!,
      );
      print("sukses");
      if (image != null) {
        var imgFileName = image.path.split('/').last;
        var imgStream =
            http.ByteStream(Stream.castFrom(XFile(image.path).openRead()));
        var imgLength = await XFile(image.path).length();
        var imgMultiPart = http.MultipartFile('foto', imgStream, imgLength,
            filename: imgFileName);
        request.files.add(imgMultiPart);
      }
      var response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("berhasil");
      }
      return "sukses";
    } catch (e) {
      return "gagal";
    }
  }

  Future<bool> deleteData(String? id) async {
    try {
      print(id);
      isLoading(true);
      String baseUrl = '${Api().baseURL}/order/$id';
      final response = await http.delete(Uri.tryParse(baseUrl)!);
      if (response.statusCode == 200) {
        print(response.statusCode);
      } else {
        print("gagal");
      }
      refresh();
      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading(false);
    }
  }
}
