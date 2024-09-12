import 'dart:convert';

import '../../../auth/controller/auth_controller.dart';
import '../../report/controller/report_controller.dart';
import '../model/semai_model.dart';
import '../../tanam/controller/tanam_controller.dart';
import '../../../../services/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class SemaiController extends GetxController {
  var controller = Get.put(TanamController());
  var reportController = Get.put(ReportController());
  // var jenisSayur = "Tidak ada data".obs;
  // var semaiList = <SemaiModel>[].obs;
  RxList<SemaiModel>? dataSemaiList = <SemaiModel>[].obs;
  XFile? image;
  var isLoading = false.obs;
  final ImagePicker picker = ImagePicker();

  late TextEditingController id;
  late TextEditingController namaSayur;
  late TextEditingController tanggal;
  late TextEditingController jumlahBibit;
  late TextEditingController waktuPenyemaian;
  late TextEditingController masaTanam;
  late TextEditingController keterangan;
  late TextEditingController gambar;
  late TextEditingController search;

  var auth = Get.put(AuthController());
  Future<void> onInit() async {
    super.onInit();
    getAllData(auth.box.read("id_kebun"));
    id = TextEditingController();
    namaSayur = TextEditingController();
    tanggal = TextEditingController();
    jumlahBibit = TextEditingController();
    waktuPenyemaian = TextEditingController();
    masaTanam = TextEditingController();
    keterangan = TextEditingController();
    gambar = TextEditingController();
    search = TextEditingController();
  }

  String formatTanggal(DateTime tanggal) {
    List<String> namaBulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];

    int tanggalNum = tanggal.day;
    String bulan = namaBulan[tanggal.month - 1];
    int tahun = tanggal.year;

    return '$tanggalNum $bulan $tahun';
  }

  getAllData(id) async {
    isLoading(true);
    try {
      String baseUrl = '${Api().baseURL}/semai/$id';
      final response = await http.get(Uri.tryParse(baseUrl)!);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> dataSemaiJsonList = data['data_semai'];
        for (var item in dataSemaiJsonList) {
          SemaiModel semaiModel = SemaiModel.fromJson(item);
          dataSemaiList!.add(semaiModel);
          print(search.text);
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
      String baseUrl = '${Api().baseURL}/semai';
      final response = await http.get(Uri.tryParse(baseUrl)!);
      if (response.statusCode == 200) {
        dataSemaiList!.clear();
        dataSemaiList!.clear();
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
      String baseUrl = '${Api().baseURL}/semai/search';
      var request = http.MultipartRequest('POST', Uri.tryParse(baseUrl)!);
      map.forEach((key, value) {
        request.fields[key] = value;
      });
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await http.Response.fromStream(response);
        dataSemaiList!.clear();
        Map<String, dynamic> data = jsonDecode(responseBody.body);
        List<dynamic> hasilSearchJsonList = data['hasil_search'];
        if (hasilSearchJsonList.isEmpty) {
          // getAllData(auth.box.read("id_kebun"));
          return "gagal";
        }
        for (var item in hasilSearchJsonList) {
          SemaiModel semaiModel = SemaiModel.fromJson(item);
          dataSemaiList!.add(semaiModel);
        }
        return "sukses";
      }
      return "gagal";
    } catch (e) {
      return "gagal";
    } finally {
      isLoading(false);
    }
  }

  // Future<String> getSpesifikData() async {
  //   try {
  //     print(search.text);
  //     if (search.text == "") {
  //       isLoading(true);
  //       refresh();
  //     } else {
  //       isLoading(true);
  //       var map = <String, dynamic>{};
  //       map['keyword'] = search.text;
  //       map['id_kebun'] = auth.box.read("id_kebun");
  //       print(auth.box.read("id_kebun"));
  //       String baseUrl = '${Api().baseURL}/semai/search';
  //       final response = await http.post(Uri.tryParse(baseUrl)!);
  //       print(response.statusCode);
  //       // print(response.body);
  //       if (response.statusCode == 200) {
  //         dataSemaiList!.clear();
  //         Map<String, dynamic> data = jsonDecode(response.body);
  //         print(data);
  //         List<dynamic> hasilSearchJsonList = data['hasil_search'];
  //         if (hasilSearchJsonList.isEmpty) {
  //           getAllData(auth.box.read("id_kebun"));
  //           return "gagal";
  //         }
  //         for (var item in hasilSearchJsonList) {
  //           SemaiModel semaiModel = SemaiModel.fromJson(item);
  //           dataSemaiList!.add(semaiModel);
  //         }
  //         return "sukses";
  //       }
  //     }
  //     return "gagal";
  //   } catch (e) {
  //     return "gagal";
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  Future sendData(image) async {
    try {
      var map = <String, dynamic>{};
      map['jenis_sayur'] = namaSayur.text;
      map['tanggal'] = tanggal.text;
      map['jumlah'] = jumlahBibit.text;
      map['waktu'] = waktuPenyemaian.text;
      String baseUrl =
          '${Api().baseURL}/semai/createSemai/${auth.box.read("id_kebun")}';
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
      if (response.statusCode == 201) {
        reportController.refresh();
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

  Future updateData(id, image) async {
    try {
      var gambarLama = gambar.text.split('/').last;
      var map = <String, dynamic>{};
      map['jenis_sayur'] = namaSayur.text;
      map['tanggal'] = tanggal.text;
      map['jumlah'] = jumlahBibit.text;
      map['waktu'] = waktuPenyemaian.text;
      var img = image;
      print(namaSayur.text);
      print(tanggal.text);
      print(gambarLama);
      print(jumlahBibit.text);
      String baseUrl = '${Api().baseURL}/semai/edit/$id';
      print("request url $baseUrl");
      print(namaSayur.text);
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
        reportController.refresh();
        return "sukses";
      } else {
        return "gagal";
      }
    } catch (e) {
      return "gagal";
    } finally {
      refresh();
    }
  }

  Future deleteData(id) async {
    try {
      String baseUrl = '${Api().baseURL}/semai/delete/$id';
      print("request url $baseUrl");
      print(namaSayur.text);
      var request = http.MultipartRequest('POST', Uri.tryParse(baseUrl)!);
      var response = await request.send();
      if (response.statusCode == 200) {
        reportController.refresh();
        refresh();
        return "sukses";
      } else {
        return "gagal";
      }
    } catch (e) {
      return "gagal";
    } finally {
      clearData();
    }
  }

  Future toTanam(id) async {
    try {
      var map = <String, dynamic>{};
      map['tanggal_tanam'] = tanggal.text;
      map['jumlah_bibit'] = jumlahBibit.text;
      map['masa_tanam'] = masaTanam.text;
      map['keterangan'] = keterangan.text;
      String baseUrl = '${Api().baseURL}/semai/toTanam/$id';
      var request = http.MultipartRequest('POST', Uri.tryParse(baseUrl)!);
      map.forEach((key, value) {
        request.fields[key] = value;
      });
      var response = await request.send();
      if (response.statusCode == 200) {
        controller.refresh();
        reportController.refresh();
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
    namaSayur.text = "";
    tanggal.text = "";
    jumlahBibit.text = "";
    waktuPenyemaian.text = "";
    masaTanam.text = "";
    keterangan.text = "";
    search.text = "";
  }

  // Future<void> fetchSemaiData() async {
  //   try {
  //     final response =
  //         await http.get(Uri.parse('${Api().baseURL}/semai/K0002'));
  //     if (response.statusCode == 200) {
  //       var responseData = json.decode(response.body);
  //       var dataSemai = responseData['data_semai'];
  //       semaiList.value = List<SemaiModel>.from(
  //           dataSemai.map((sem) => SemaiModel.fromJson(sem)));
  //     }
  //   } catch (e) {
  //     print('Exception : $e');
  //   }
  // }

  // void addSemai(SemaiModel semaiModel) {
  //   semaiList.add(semaiModel);
  //   Get.back();
  //   print("Semai Lenth : ${semaiList.length}");
  // }
}

  // Future<void> fetchSemai() async {
  //   try {
  //     final response =
  //         await http.get(Uri.parse("${Api().baseURL}/semai/K0002"));
  //     if (response.statusCode == 200) {
  //       print('Response body: ${response.body}');
  //       var data = json.decode(response.body);
  //       var dataSemai = data['data_semai'];
  //       if (dataSemai.isNotEmpty) {
  //         var firstSemaiData = dataSemai[0];
  //         print("Data 1: ${firstSemaiData}");
  //         var semai = SemaiModel.fromJson(firstSemaiData);
  //         print('Data jenis Sayur: ${semai}');
  //         jenisSayur.value = semai.jenisSayur;
  //       }
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString());
  //     print('Exception: $e');
  //   }
  // }

