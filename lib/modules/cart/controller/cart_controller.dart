import 'dart:convert';

import '../model/cart_model.dart';
import '../../order/controller/order_controller.dart';
import '../../../services/api.dart';
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
  late TextEditingController amount;

  @override
  Future<void> onInit() async {
    super.onInit();
    id = TextEditingController();
    nama = TextEditingController();
    harga = TextEditingController();
    foto = TextEditingController();
    amount = TextEditingController();
  }

  var order = Get.put(OrderController());

  Future<String> tambahData(String id, String nama, String harga, String foto,
      String namaPetani, int amount) async {
    try {
      if (amount <= 0) {
        return "gagal";
      }

      bool dataAda = dataList!.any((item) =>
          item.id == id &&
          item.nama == nama &&
          item.harga == harga &&
          item.amount == amount);
      if (dataAda) {
        return "duplikat";
      }

      bool petaniBeda =
          dataList!.any((element) => element.namaPetani != namaPetani);
      if (petaniBeda) {
        return "petani beda";
      }

      var map = <String, dynamic>{};
      map['id'] = id;
      map['nama'] = nama;
      map['harga'] = harga;
      map['foto'] = foto;
      map['amount'] = amount;
      amount = map['amount'];
      map['nama_petani'] = namaPetani;
      CartModel cartModel = CartModel(
          id: id,
          nama: nama,
          foto: foto,
          harga: harga,
          amount: amount,
          namaPetani: namaPetani);
      dataList!.add(cartModel);
      return "sukses";
    } catch (e) {
      return "gagal";
    } finally {}
  }

  Future<String> sendData(double harga, String idUser) async {
    try {
      if (order.dataBelumList!.isNotEmpty) {
        return "sudah";
      }
      String totalHarga = harga.toString();
      var map = <String, dynamic>{};
      map["total_harga_produk"] = totalHarga;
      map["status"] = "belum bayar";
      map["data_produk"] = dataList;
      map['id_user'] = idUser;
      String data = jsonEncode(map);
      print(data);
      // var map2 = <String, dynamic>{};
      String baseUrl = '${Api().baseURL}/order';
      final response = await http.post(Uri.tryParse(baseUrl)!, body: data);
      print(response.statusCode);
      if (response.statusCode == 201) {
        return "sukses";
      } else {
        return "gagal";
      }
    } catch (e) {
      // Get.snackbar("Error", e.toString());
      return "gagal";
    } finally {}
  }

  Future<String> deleteData(id, int amount) async {
    try {
      dataList!.removeWhere(
          (element) => element.id == id && element.amount == amount);
      isLoading(true);
      return "sukses";
    } catch (e) {
      return "gagal";
    } finally {
      isLoading(false);
    }
  }

  clearData() {
    dataList!.clear();
  }
}
