import 'dart:convert';

import 'package:apehipo_app/modules/catalog/katalog_screen.dart';
import 'package:apehipo_app/widgets/success_confirmation_dialog.dart';
import 'package:image_picker/image_picker.dart';

import 'catalog_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../services/api.dart';

class CatalogController extends GetxController {
  List<CatalogModel>? dataTampilList = [];
  List<CatalogModel>? dataArsipList = [];
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

  @override
  Future<void> onInit() async {
    super.onInit();
    getAllData();
    nama = TextEditingController();
    jenis = TextEditingController();
    harga = TextEditingController();
    stok = TextEditingController();
    deskripsi = TextEditingController();
    status = TextEditingController();
    idUser = TextEditingController();
    foto = TextEditingController();
  }

  getAllData() async {
    try {
      isLoading(true);
      String baseUrl = '${Api().baseURL}/product';
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
      }
    } catch (e) {
      Get.snackbar("kesalahan", e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future refresh() async {
    try {
      isLoading(true);
      String baseUrl = '${Api().baseURL}/product';
      final response = await http.get(Uri.tryParse(baseUrl)!);
      print(response.statusCode);
      if (response.statusCode == 200) {
        dataTampilList!.clear();
        dataArsipList!.clear();
      }
    } catch (e) {
    } finally {
      isLoading(true);
      getAllData();
    }
  }

  //

  Future sendData(image) async {
    try {
      var map = <String, dynamic>{};
      map['nama'] = nama.text;
      map['jenis'] = "Sayur";
      map['harga'] = harga.text;
      map['stok'] = stok.text;
      map['deskripsi'] = deskripsi.text;
      map['status'] = "arsip";
      map['id_user'] = "0001";
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
        SuccessConfirmationDialog(message: "Anda berhasil menyimpan perubahan");
      } else {
        // Tangani jika request gagal
        print('Failed to send data: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar("Gagal", e.toString());
    } finally {
      clearData();
      Get.off(CatalogScreen());
      refresh();
    }
  }

  void clearData() {
    nama.text = "";
    jenis.text = "";
    harga.text = "";
    stok.text = "";
    deskripsi.text = "";
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
        SuccessConfirmationDialog(
          message: "Anda berhasil menghapus produk ini",
        );
      } else {
        print('Failed to send data: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar("Gagal", e.toString());
    } finally {
      refresh();
    }
  }

  updateData(String id, XFile image) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.tryParse('${Api().baseURL}/product/ubah/$id')!,
      );

      var map = <String, dynamic>{};
      map['nama'] = nama.text;
      map['jenis'] = "Sayur";
      map['harga'] = harga.text;
      map['stok'] = stok.text;
      map['deskripsi'] = deskripsi.text;
      map['klasifikasi'] = "biasa";
      map['status'] = "arsip";
      map['id_user'] = "0001";

      // Menambahkan data string ke dalam request
      request.fields['nama'] = nama.text;
      request.fields['jenis'] = "sayur";
      request.fields['harga'] = harga.text;
      request.fields['stok'] = stok.text;
      request.fields['deskripsi'] = deskripsi.text;
      request.fields['klasifikasi'] = "biasa";
      request.fields['status'] = "arsip";
      request.fields['id_user'] = "0001";
      print(id);
      map.forEach((key, value) {
        request.fields[key] = value;
      });
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
      if (response.statusCode == 200) {
        SuccessConfirmationDialog(message: "Anda berhasil menyimpan perubahan");
      } else {
        print("Gagal mengirim data");
      }
    } catch (e) {
      Get.snackbar("Gagal", e.toString());
    } finally {}
  }

  ubahStatus(id) async {
    try {
      isLoading(true);
      String baseUrl = '${Api().baseURL}/product/$id';
      final response = await http.put(Uri.tryParse(baseUrl)!);
    } catch (e) {
      Get.snackbar("kesalahan", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
