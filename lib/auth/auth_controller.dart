import 'dart:convert';
import 'dart:io';

import 'package:apehipo_app/auth/auth_model.dart';
import 'package:apehipo_app/auth/login/login.dart';
import 'package:apehipo_app/modules/account/account_controller.dart';
import 'package:get_storage/get_storage.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../services/api.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  final box = GetStorage();

  late TextEditingController nama;
  late TextEditingController noTelpon;
  late TextEditingController noRekening;
  late TextEditingController alamat;
  late TextEditingController username;
  late TextEditingController password;
  late TextEditingController email;
  late TextEditingController role;

  @override
  onInit() async {
    super.onInit();
    nama = TextEditingController();
    noTelpon = TextEditingController();
    noRekening = TextEditingController();
    alamat = TextEditingController();
    username = TextEditingController();
    password = TextEditingController();
    email = TextEditingController();
    role = TextEditingController();
  }

  //

  Future<String> doLogin() async {
    try {
      var map = <String, dynamic>{};
      map['username'] = username.text;
      map['password'] = password.text;
      if (map['username'] == "" || map['password'] == "") {
        return "Username dan Password Salah";
      }
      // Membuat HTTP request
      String baseUrl = '${Api().baseURL}/auth';
      final response = await http.post(Uri.tryParse(baseUrl)!, body: map);
      // Menambahkan data string ke dalam request
      print(response.statusCode);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var data = AuthModel.fromJson(result);
        var username = data.username;
        String baseUrl = '${Api().baseURL}/auth/$username';
        final responseSecond = await http.get(
          Uri.tryParse(baseUrl)!,
        );
        if (responseSecond.statusCode == 200) {
          result = jsonDecode(responseSecond.body);
          data = AuthModel.fromJson(result);
        }
        await box.write("id_user", data.idUser);
        await box.write("nama", data.nama);
        await box.write("role", data.role);
        return "sukses";
      } else {
        return "gagal";
      }
    } catch (e) {
      Get.snackbar("Gagal", e.toString());
      return "gagal";
    }
  }

  Future<String> createAccount() async {
    try {
      var map = <String, dynamic>{};
      map['nama'] = nama.text;
      map['no_telpon'] = noTelpon.text;
      map['no_rekening'] = noRekening.text;
      map['alamat'] = alamat.text;
      map['username'] = username.text;
      map['email'] = email.text;
      map['password'] = password.text;
      map['role'] = role.text;

      // membuat HTTP request
      String baseUrl = '${Api().baseURL}/auth/register';
      print(baseUrl);
      final response = await http.post(Uri.tryParse(baseUrl)!, body: map);
      print(response.statusCode);
      if (response.statusCode == 201) {
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

  void clearData() {
    username.text = "";
    email.text = "";
    password.text = "";
    nama.text = "";
    noTelpon.text = "";
    noRekening.text = "";
    alamat.text = "";
  }

  logOut() async {
    box.remove("id_user");
    box.remove("nama");
    box.remove("role");
    clearData();
    await Get.offAll(LoginPage());
  }
}
