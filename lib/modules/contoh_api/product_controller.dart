import 'dart:convert';
// import 'dart:io';

import 'package:apehipo_app/modules/contoh_api/product_model.dart';
import 'package:apehipo_app/modules/contoh_api/product_show.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../services/api.dart';

class ProductController extends GetxController {
  List<ProductModel>? dataList = [];
  var isLoading = false.obs;

  late TextEditingController kode;
  late TextEditingController nama;
  @override
  Future<void> onInit() async {
    super.onInit();
    getAllData();
    kode = TextEditingController();
    nama = TextEditingController();
  }

  getAllData() async {
    try {
      isLoading(true);
      String baseUrl = '${Api().baseURL}/product';
      print(baseUrl);
      final response = await http.get(Uri.tryParse(baseUrl)!);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body); // Ubah 'result' menjadi 'data'
        dataList = data.map((x) => ProductModel.fromJson(x)).toList();
        // Konversi nilai harga dan stok sesuai tipe yang diinginkan
        // double harga = double.parse(element['harga']);
        // int stok = int.parse(element['stok']);
        // Return object ProductModel yang telah diubah nilai harga dan stoknya
        //   return ProductModel(
        //     kode: element['kode'],
        //     nama: element['nama'],
        //     jenis: element['jenis'],
        //     harga: harga,
        //     stok: stok,
        //     deskripsi: element['deskripsi'],
        //     foto: element['foto'],
        //     kodeKebun: element['kode_kebun'],
        //   );
        // }).toList();
      } else {
        Get.snackbar("Pesan", "Data error");
      }
    } on Exception catch (_, e) {
      dataList = [];
    } finally {
      isLoading(false);
    }
  }

  sendData() async {
    try {
      var map = <String, dynamic>{};
      map['kode'] = kode.text;
      map['nama'] = nama.text;
      String baseUrl = '${Api().baseURL}/apehipo_web/public/product';
      final response = await http.post(Uri.tryParse(baseUrl)!, body: map);
      if (response.statusCode == 201) {
        Get.snackbar("Pesan", "Berhasil disimpan");
      }
    } on Exception catch (_, e) {
      Get.snackbar("Pesan", "Terjadi kesalahan sistem");
    } finally {
      Get.snackbar("Pesan", "Berhasil disimpan");
    }
  }

  showData(String id) async {
    try {
      isLoading(true);
      var map = <String, dynamic>{};
      String baseUrl = '${Api().baseURL}/apehipo_web/public/product/$id';
      final response = await http.get(Uri.tryParse(baseUrl)!);
      if (response.statusCode == 200) {
        map = jsonDecode(response.body);
        String id = map['kode_produk'];
        String produk = map['nama_produk'];
        Get.to(ProductShow(id, produk));
      } else {
        Get.snackbar("Pesan", "Gagal mendapatkan data");
      }
    } on Exception catch (_, e) {
      isLoading(false);
      Get.snackbar(e.toString(), "Terjadi kesalahan sistem");
    } finally {
      isLoading(false);
      Get.snackbar("Pesan", "Berhasil mendapatkan data");
    }
  }

  updateData(String id) async {
    try {
      var map = <String, dynamic>{};
      map['nama'] = nama.text;
      String baseUrl = '${Api().baseURL}/apehipo_web/public/product/$id';
      print(baseUrl);
      final response = await http.put(Uri.tryParse(baseUrl)!,
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
          body: map);
      if (response.statusCode == 200) {
        Get.snackbar("Pesan", "Berhasil diupdate");
      } else {
        Get.snackbar("Pesan", "Gagal mengupdate data");
      }
    } catch (e) {
      Get.snackbar("Pesan", "Terjadi kesalahan");
      print(e);
    }
  }

  deleteData(String id) async {
    try {
      String baseUrl = '${Api().baseURL}/apehipo_web/public/product/$id';
      print(baseUrl);
      final response = await http.delete(
        Uri.tryParse(baseUrl)!,
        headers: {
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*",
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        Get.snackbar("Pesan", "Berhasil dihapus");
      } else {
        Get.snackbar("Pesan", "Gagal menghapus data");
      }
    } catch (e) {
      print(e);
      Get.snackbar(e.toString(), "Terjadi kesalahan sistem");
    }
  }
}
