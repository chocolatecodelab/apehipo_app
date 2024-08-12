import 'dart:convert';

import '../model/auth_model.dart';
import '../../../widgets/popup_loading_widget.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../services/api.dart';

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
      isLoading(true);
      final _firebaseMessaging = FirebaseMessaging.instance;
      final fcmToken = await _firebaseMessaging.getToken();
      print("Token: $fcmToken");
      var map = <String, dynamic>{};
      map['username'] = username.text;
      map['password'] = password.text;
      map['fcmToken'] = fcmToken;
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
        print(result);
        var data = AuthModel.fromJson(result);
        await box.write("id_kebun", data.idKebun);
        var username = data.username;
        String baseUrl = '${Api().baseURL}/auth/$username';
        final responseSecond = await http.get(
          Uri.tryParse(baseUrl)!,
        );
        if (responseSecond.statusCode == 200) {
          result = jsonDecode(responseSecond.body);
          print(result);
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
      // Get.snackbar("Gagal", e.toString());
      return "gagal";
    } finally {
      isLoading(false);
    }
  }

  Future<String> createAccount() async {
    try {
      // Validasi username
      if (username.text.length < 5) {
        // Tampilkan pesan kesalahan: "Username harus memiliki setidaknya 5 karakter."
        return "Username harus memiliki setidaknya 5 karakter.";
      } else if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(username.text)) {
        // Tampilkan pesan kesalahan: "Username hanya boleh mengandung huruf dan angka."
        return "Username hanya boleh mengandung huruf dan angka.";
      }

      if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
          .hasMatch(email.text)) {
        // Tampilkan pesan kesalahan: "Email tidak valid."
        return "Email tidak valid.";
      }

      if (password.text.length < 8) {
        // Tampilkan pesan kesalahan: "Password harus memiliki setidaknya 8 karakter."
        return "Password harus memiliki setidaknya 8 karakter.";
      } else if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$')
          .hasMatch(password.text)) {
        // Tampilkan pesan kesalahan: "Password harus mengandung huruf besar, huruf kecil, angka, dan karakter khusus."
        return "Password harus mengandung huruf besar, huruf kecil, angka, dan karakter khusus.";
      }

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
      final jsonResponse = json.decode(response.body);
      final status = jsonResponse['status'];
      print(status);
      if (status == "201") {
        clearData();
        return "sukses";
      } else if (status == "404") {
        print("disini");
        return "Username atau Email anda sudah diambil";
      } else {
        print("atau disini");
        return "gagal";
      }
    } catch (e) {
      return "gagal";
    } finally {}
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

  Future<String> logOut() async {
    try {
      box.remove("id_user");
      box.remove("nama");
      box.remove("role");
      box.remove("id_kebun");
      clearData();
      isLoading(false);

      return "sukses";
    } catch (e) {
      return "gagal";
    }
  }
}
