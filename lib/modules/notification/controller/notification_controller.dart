import 'dart:convert';
import 'package:Apehipo/modules/auth/controller/auth_controller.dart';
import 'package:Apehipo/modules/notification/model/notif_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../services/api.dart';

class NotificationController extends GetxController {
  List<NotifModel>? dataList = [];
  var isLoading = false.obs;

  var auth = Get.put(AuthController());
  Future<void> onInit() async {
    super.onInit();
    getAllData(auth.box.read("id_user"));
  }

  Future getAllData(id) async {
    try {
      isLoading(true);
      String baseUrl = '${Api().baseURL}/notifikasi/$id';
      final response = await http.get(Uri.tryParse(baseUrl)!);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.statusCode);
        List data = jsonDecode(response.body); // Ubah 'result' menjadi 'data'
        print(data);
        dataList = data.map((x) => NotifModel.fromJson(x)).toList();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future refresh() async {
    try {
      isLoading(true);
      dataList!.clear();
    } catch (e) {
    } finally {
      isLoading(true);
      getAllData(auth.box.read("id_user"));
    }
  }

  Future sendData(String pesan, String detailPesan, String idPenerima,
      String idPengirim) async {
    try {
      var map = <String, dynamic>{};
      map['pesan'] = pesan;
      map['detail_pesan'] = detailPesan;
      map['id_penerima'] = idPenerima;
      map['id_pengirim'] = idPengirim;
      String baseUrl = '${Api().baseURL}/notifikasi';
      final response = await http.post(Uri.tryParse(baseUrl)!, body: map);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.statusCode);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<String> ubahData(String id) async {
    try {
      var map = <String, dynamic>{};
      map['status'] = "true";
      String baseurl = '${Api().baseURL}/notifikasi/status/$id';
      final response = await http.post(Uri.tryParse(baseurl)!, body: map);
      if (response.statusCode == 200) {
        print(response.statusCode);
        refresh();
        return "sukses";
      } else {
        return "gagal";
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan");
      return "gagal";
    } finally {}
  }

  Future<String> deleteData(String id) async {
    try {
      String baseurl = '${Api().baseURL}/notifikasi/$id';
      final response = await http.delete(Uri.tryParse(baseurl)!);
      if (response.statusCode == 200) {
        print(response.statusCode);
        refresh();
        return "sukses";
      } else {
        return "gagal";
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan");
      return "gagal";
    } finally {}
  }
}
