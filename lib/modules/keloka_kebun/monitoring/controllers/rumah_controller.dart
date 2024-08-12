import 'dart:convert';

import '../../../auth/controller/auth_controller.dart';
import '../model/monitoring_model.dart';
import '../../../../services/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../model/rumah_model.dart';

class RumahController extends GetxController {
  // final controllerMonitoring = Get.put(MonitoringController());

  late TextEditingController namaController;
  late TextEditingController kapasistasController;
  late TextEditingController keteranganController;
  late TextEditingController gambarController;

  late TextEditingController ppmController;
  late TextEditingController phController;
  RxString tanggal = "".obs;

  XFile? image;

  RxList<RumahModel> dataRumahList = <RumahModel>[].obs;
  RxList<MonitoringModel> dataMonitoringList = <MonitoringModel>[].obs;

  RxBool isLoading = false.obs;
  final ImagePicker picker = ImagePicker();

  var auth = Get.put(AuthController());

  Future<void> onInit() async {
    super.onInit();
    getAllDataRumah(auth.box.read("id_kebun"));
    namaController = TextEditingController();
    kapasistasController = TextEditingController();
    keteranganController = TextEditingController();
    gambarController = TextEditingController();
    ppmController = TextEditingController();
    phController = TextEditingController();
    tanggal.value = DateTime.now().toString().split(" ")[0];
  }

  Future refreshDataMonitoring() async {
    try {
      isLoading(true);
      dataMonitoringList.clear();
      print("Panjang Refresh : ${dataRumahList[0].idRumah}");
      List<String> rumahIds =
          dataRumahList.map((element) => element.idRumah).toList();
      print(rumahIds.length);
      for (var id in rumahIds) {
        await getAllDataMonitoring(id);
      }
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }

  Future refreshDataRumah() async {
    try {
      isLoading(true);
      String baseUrl = '${Api().baseURL}/rumah';
      final response = await http.get(Uri.tryParse(baseUrl)!);
      if (response.statusCode == 200) {
        dataRumahList.clear();
        dataRumahList.clear();
      }
    } catch (e) {
    } finally {
      isLoading(true);
      getAllDataRumah(auth.box.read("id_kebun"));
    }
  }

  getAllDataMonitoring(id) async {
    isLoading(true);
    try {
      String baseUrl = '${Api().baseURL}/monitoring/$id/${tanggal.value}';
      // print(baseUrl);
      final response = await http.get(Uri.tryParse(baseUrl)!);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        List<dynamic> dataMonitoringJsonList = responseBody['data_monitoring'];
        for (var item in dataMonitoringJsonList) {
          MonitoringModel dataMonitoringModel = MonitoringModel.fromJson(item);
          dataMonitoringList.add(dataMonitoringModel);
        }
      }
    } catch (e) {
      print("${Api().baseURL}/monitoring/$id/$tanggal");
      print("Catch $e");
    } finally {
      isLoading(false);
    }
  }

  getAllDataRumah(id) async {
    isLoading(true);
    try {
      String baseUrl = '${Api().baseURL}/rumah/$id';
      final response = await http.get(Uri.tryParse(baseUrl)!);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        List<dynamic> dataRumahJsonList = responseBody['data_rumah'];
        for (var item in dataRumahJsonList) {
          RumahModel dataRumahModel = RumahModel.fromJson(item);
          dataRumahList.add(dataRumahModel);
          print("ID RUMAH : ${dataRumahModel.idRumah}");
          await getAllDataMonitoring(dataRumahModel.idRumah);
          // controllerMonitoring.getAllData(dataRumahModel.idRumah);
          // print(
          //     "ID RUMAH Monitoring: ${controllerMonitoring.dataMonitoringList[0].idRumah}");
        }
      }
    } catch (e) {
      print("Catch $e");
    } finally {
      isLoading(false);
    }
  }

  Future sendDataMonitoring(id) async {
    try {
      var map = <String, dynamic>{};
      map['ppm'] = ppmController.text;
      map['ph'] = phController.text;
      map['tanggal'] = tanggal.value;
      String baseUrl = '${Api().baseURL}/monitoring/createMonitoring/$id';
      var request = http.MultipartRequest('POST', Uri.tryParse(baseUrl)!);
      map.forEach((key, value) {
        request.fields[key] = value;
      });

      var response = await request.send();
      if (response.statusCode == 200) {
        refreshDataMonitoring();
        return "sukses";
      } else {
        print(response.statusCode);
        return "gagal";
      }
    } catch (e) {
      print(e);
      return "gagal";
    } finally {
      clearDataMonitoring();
    }
  }

  Future sendDataRumah(image) async {
    try {
      var map = <String, dynamic>{};
      map['nama_rumah'] = namaController.text;
      map['kapasitas'] = kapasistasController.text;
      map['deskripsi'] = keteranganController.text;
      String baseUrl =
          '${Api().baseURL}/rumah/createRumah/${auth.box.read("id_kebun")}';
      var request = http.MultipartRequest('POST', Uri.tryParse(baseUrl)!);
      map.forEach((key, value) {
        request.fields[key] = value;
      });
      var img = image;
      if (img != null) {
        var imgFileName = img.path.split('/').last;
        print(imgFileName);
        var imgStream =
            http.ByteStream(Stream.castFrom(XFile(img.path).openRead()));
        var imgLength = await XFile(img.path).length();
        var imgMultiPart = http.MultipartFile('gambar', imgStream, imgLength,
            filename: imgFileName);
        request.files.add(imgMultiPart);
      }
      var response = await request.send();
      if (response.statusCode == 200) {
        refreshDataRumah();
        return "sukses";
      } else {
        print(response.statusCode);
        return "gagal";
      }
    } catch (e) {
      print(e);
      return "gagal";
    } finally {
      clearDataRumah();
    }
  }

  Future updateDataMonitoring(id) async {
    try {
      var map = <String, dynamic>{};
      map['ppm'] = ppmController.text;
      map['ph'] = phController.text;
      String baseUrl = '${Api().baseURL}/monitoring/edit/$id';
      print(baseUrl);
      var request = http.MultipartRequest('POST', Uri.tryParse(baseUrl)!);
      map.forEach((key, value) {
        request.fields[key] = value;
      });
      var response = await request.send();
      print("Respon ${response.statusCode}");
      if (response.statusCode == 200) {
        refreshDataMonitoring();
        return "sukses";
      } else {
        return "gagal";
      }
    } catch (e) {
      return "gagal";
    } finally {}
  }

  Future updateDataRumah(id, image) async {
    try {
      var gambarLama = gambarController.text.split('/').last;
      var map = <String, dynamic>{};
      map['nama_rumah'] = namaController.text;
      map['kapasitas'] = kapasistasController.text;
      map['deskripsi'] = keteranganController.text;
      var img = image;
      String baseUrl = '${Api().baseURL}/rumah/edit/$id';
      var request = http.MultipartRequest('POST', Uri.tryParse(baseUrl)!);
      map.forEach((key, value) {
        request.fields[key] = value;
      });
      request.fields['gambar_lama'] = gambarLama;
      request.headers['Authorization'] = "";
      print("id : $id");
      print(img);
      if (img != null) {
        var imgFileName = img.path.split('/').last;
        print(imgFileName);
        var imgStream =
            http.ByteStream(Stream.castFrom(XFile(img.path).openRead()));
        var imgLength = await XFile(img.path).length();
        var imgMultiPart = http.MultipartFile(
            'gambar_baru', imgStream, imgLength,
            filename: imgFileName);
        print(imgStream);
        print(imgLength);
        print(img.path);
        request.files.add(imgMultiPart);
      } else {}
      var response = await request.send();
      print("Respon ${response.statusCode}");
      if (response.statusCode == 200) {
        return "sukses";
      } else {
        return "gagal";
      }
    } catch (e) {
      return "gagal";
    } finally {
      refreshDataRumah();
    }
  }

  void clearDataRumah() {
    namaController.text = "";
    kapasistasController.text = "";
    keteranganController.text = "";
  }

  void clearDataMonitoring() {
    ppmController.text = "";
    phController.text = "";
  }
}
