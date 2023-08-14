import 'dart:convert';

import 'package:apehipo_app/auth/auth_model.dart';
import 'package:apehipo_app/auth/login/login.dart';
import 'package:apehipo_app/modules/catalog/katalog_screen.dart';
import 'package:apehipo_app/widgets/success_confirmation_dialog.dart';
import 'package:get_storage/get_storage.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../services/api.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  final box = GetStorage();

  late TextEditingController username;
  late TextEditingController password;

  @override
  onInit() async {
    super.onInit();
    username = TextEditingController();
    password = TextEditingController();
  }

  //

  doLogin() async {
    try {
      var map = <String, dynamic>{};
      map['username'] = username.text;
      map['password'] = password.text;

      // Membuat HTTP request
      String baseUrl = '${Api().baseURL}/auth';
      final response = await http.post(Uri.tryParse(baseUrl)!, body: map);
      // Menambahkan data string ke dalam request

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var data = AuthModel.fromJson(result);
        await box.write("username", data.username);
        SuccessConfirmationDialog(message: "Anda berhasil login");
      } else {
        // Tangani jika request gagal
        print('Failed to send data: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar("Gagal", e.toString());
    } finally {
      Get.off(CatalogScreen());
      refresh();
    }
  }

  logOut() async {
    box.remove("username");
    await Get.offAll(LoginPage());
  }
}
