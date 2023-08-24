import 'dart:convert';

import 'package:apehipo_app/modules/cart/cart_model.dart';
import 'package:apehipo_app/modules/cart/cart_screen.dart';
import 'package:apehipo_app/modules/cart/order_model.dart';
import 'package:apehipo_app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CartController extends GetxController {
  List<CartModel>? dataList = [];
  var isLoading = false.obs;
  late TextEditingController id;
  late TextEditingController nama;
  late TextEditingController harga;
  late TextEditingController foto;

  @override
  Future<void> onInit() async {
    super.onInit();
    getAllData();
    id = TextEditingController();
    nama = TextEditingController();
    harga = TextEditingController();
    foto = TextEditingController();
  }

  getAllData() async {
    try {
      isLoading(true);
      String baseUrl = '${Api().baseURL}/order';
      print(baseUrl);
      final response = await http.get(Uri.tryParse(baseUrl)!);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        dataList = data.map((x) => CartModel.fromJson(x)).toList();
      }
    } catch (e) {
      Get.snackbar("Pesan", e.toString());
    } finally {
      isLoading(false);
    }
  }

  sendData(String totalHargaProduk) async {
    try {
      var map = <String, dynamic>{};
      map['total_harga_produk'] = totalHargaProduk;
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }

  Future<String> tambahData(
      String id, String nama, String harga, String foto) async {
    try {
      var map = <String, dynamic>{};
      map['id'] = id;
      map['nama'] = nama;
      map['harga'] = harga;
      map['foto'] = foto;
      print(map['id']);
      CartModel cartModel =
          CartModel(id: id, nama: nama, foto: foto, harga: harga);
      dataList!.add(cartModel);
      return "sukses";
    } catch (e) {
      return "gagal";
    } finally {}
  }

  deleteData(id) {
    try {
      dataList!.removeWhere((element) => element.id == id);
    } catch (e) {
    } finally {}
  }
}
