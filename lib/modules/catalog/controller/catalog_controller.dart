import 'dart:convert';

import 'package:Apehipo/modules/auth/controller/auth_controller.dart';
import 'package:image_picker/image_picker.dart';

import '../model/catalog_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../services/api.dart';

class CatalogController extends GetxController {
  RxList<CatalogModel>? dataTampilList = <CatalogModel>[].obs;
  RxList<CatalogModel>? dataArsipList = <CatalogModel>[].obs;
  RxList<CatalogModel> dataGabungList = <CatalogModel>[].obs;
  int jumlahDataGabung = 0;
  XFile? image;
  var isLoading = false.obs;
  final ImagePicker picker = ImagePicker();

  late TextEditingController nama;
  late TextEditingController jenis;
  late TextEditingController harga;
  late TextEditingController stok;
  late TextEditingController deskripsi;
  late TextEditingController status;
  late TextEditingController idUser;
  late TextEditingController foto;

  var auth = Get.put(AuthController());
  Future<void> onInit() async {
    super.onInit();
    getAllData(auth.box.read("id_user"));
    nama = TextEditingController();
    jenis = TextEditingController();
    harga = TextEditingController();
    stok = TextEditingController();
    deskripsi = TextEditingController();
    status = TextEditingController();
    idUser = TextEditingController();
    foto = TextEditingController();
  }

  getAllData(id) async {
    try {
      isLoading(true);
      String baseUrl = '${Api().baseURL}/product/$id';
      final response = await http.get(Uri.tryParse(baseUrl)!);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> dataTampilJsonList = data['data_tampil'];
        for (var item in dataTampilJsonList) {
          CatalogModel catalogModel = CatalogModel.fromJson(item);
          dataTampilList!.add(catalogModel);
        }

        List<dynamic> dataArsipJsonList = data['data_arsip'];
        for (var item in dataArsipJsonList) {
          CatalogModel catalogModel = CatalogModel.fromJson(item);
          dataArsipList!.add(catalogModel);
        }
        List<CatalogModel> dataGabungList = [
          ...dataTampilList!,
          ...dataArsipList!
        ];
        jumlahDataGabung = dataGabungList.length;
      }
    } catch (e) {
      // Get.snackbar("kesalahan", e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future refresh() async {
    try {
      isLoading(true);
      String baseUrl = '${Api().baseURL}/product';
      final response = await http.get(Uri.tryParse(baseUrl)!);
      if (response.statusCode == 200) {
        dataTampilList!.clear();
        dataArsipList!.clear();
      }
    } catch (e) {
    } finally {
      isLoading(true);
      getAllData(auth.box.read("id_user"));
    }
  }

  //

  Future sendData(image) async {
    try {
      var map = <String, dynamic>{};
      map['nama'] = nama.text;
      map['jenis'] = jenis.text;
      map['harga'] = harga.text;
      map['stok'] = stok.text;
      map['deskripsi'] = deskripsi.text;
      map['status'] = "arsip";
      map['id_user'] = auth.box.read("id_user");
      var img = image;
      if (img == null) {
        // Jika gambar tidak dipilih, maka berhentikan proses pengiriman data.
        return;
      }
      // Membuat HTTP request
      String baseUrl = '${Api().baseURL}/product';
      var request = http.MultipartRequest('POST', Uri.tryParse(baseUrl)!);
      // Menambahkan data string ke dalam request
      map.forEach((key, value) {
        request.fields[key] = value;
      });
      // Menambahkan data gambar (image) ke dalam request
      var imgFileName = img.path.split('/').last;
      var imgStream =
          http.ByteStream(Stream.castFrom(XFile(img.path).openRead()));
      var imgLength = await XFile(img.path).length();
      var imgMultiPart = http.MultipartFile('foto', imgStream, imgLength,
          filename: imgFileName);
      request.files.add(imgMultiPart);
      // Mengirim request dan menunggu responsenya
      var response = await request.send();
      if (response.statusCode == 201) {
      } else {
        // Tangani jika request gagal
        print('Failed to send data: ${response.statusCode}');
      }
    } catch (e) {
      // Get.snackbar("Gagal", e.toString());
    } finally {
      clearData();
    }
  }

  void clearData() {
    nama.text = "";
    jenis.text = "";
    harga.text = "";
    stok.text = "";
    deskripsi.text = "";
    status.text = "";
  }

  Future deleteData(String id) async {
    try {
      print(id);
      String baseUrl = '${Api().baseURL}/product/$id';
      print(baseUrl);
      final response = await http.delete(
        Uri.tryParse(baseUrl)!,
        headers: {
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
      );
      print("sukses");
      if (response.statusCode == 200) {
      } else {
        print('Failed to send data: ${response.statusCode}');
      }
    } catch (e) {
      // Get.snackbar("Gagal", e.toString());
    } finally {
      refresh();
    }
  }

  Future<String> updateData(String id, XFile? image) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.tryParse('${Api().baseURL}/product/ubah/$id')!,
      );
      // split nama foto
      var fotoLama = foto.text.split('/').last;

      var map = <String, dynamic>{};
      map['nama'] = nama.text;
      map['jenis'] = jenis.text;
      map['harga'] = harga.text;
      map['stok'] = stok.text;
      map['deskripsi'] = deskripsi.text;
      map.forEach((key, value) {
        request.fields[key] = value;
      });
      request.fields['fotoLama'] = fotoLama;
      request.headers['Authorization'] = "";
      // Menambahkan data gambar (image) ke dalam request
      if (image != null) {
        var imgFileName = image.path.split('/').last;
        var imgStream =
            http.ByteStream(Stream.castFrom(XFile(image.path).openRead()));
        var imgLength = await XFile(image.path).length();
        var imgMultiPart = http.MultipartFile('foto', imgStream, imgLength,
            filename: imgFileName);
        request.files.add(imgMultiPart);
      }
      // Mengirim request dan menunggu responsenya
      var response = await request.send();
      print(response.statusCode);
      return "sukses";
    } catch (e) {
      // Get.snackbar("Gagal", e.toString());
      return "gagal";
    } finally {
      clearData();
      refresh();
    }
  }

  ubahStatus(id, status) async {
    try {
      String statusProduk =
          status == "tampil" ? status = "arsip" : status = "tampil";
      var map = <String, dynamic>{};
      map['status'] = statusProduk;
      isLoading(true);
      String baseUrl = '${Api().baseURL}/product/status/$id';
      final response = await http.post(Uri.tryParse(baseUrl)!, body: map);
      print(response.statusCode);
      if (response.statusCode == 200) {
      } else {}
    } catch (e) {
      // Get.snackbar("kesalahan", e.toString());
    } finally {
      isLoading(false);
      clearData();
      refresh();
    }
  }
}
