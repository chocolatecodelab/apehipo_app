import 'dart:convert';

import 'package:apehipo_app/auth/auth_controller.dart';
import 'package:image_picker/image_picker.dart';

import 'account_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../services/api.dart';

class AccountController extends GetxController {
  List<AccountModel>? list = [];
  var map = <String, dynamic>{};
  XFile? image;
  var isLoading = false.obs;
  final ImagePicker picker = ImagePicker();

  late TextEditingController nama;
  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController alamat;
  late TextEditingController noTelpon;
  late TextEditingController foto;
  late TextEditingController noRekening;
  late TextEditingController role;

  @override
  var auth = Get.put(AuthController());
  Future<void> onInit() async {
    super.onInit();
    getData(auth.box.read("id_user"));
    nama = TextEditingController();
    username = TextEditingController();
    email = TextEditingController();
    alamat = TextEditingController();
    noTelpon = TextEditingController();
    foto = TextEditingController();
    if (auth.box.read("role") == "petani") {
      noRekening = TextEditingController();
    }
    role = TextEditingController();
  }

  getData(id) async {
    try {
      isLoading(true);
      String baseUrl = '${Api().baseURL}/account/$id';
      final response = await http.get(Uri.tryParse(baseUrl)!);
      print(response.statusCode);
      if (response.statusCode == 200) {
        map = jsonDecode(response.body); // Ubah 'result' menjadi 'data'
        nama.text = map['nama'];
        role.text = auth.box.read("role");
        username.text = map['username'];
        email.text = map['email'];
        alamat.text = map['alamat'];
        noTelpon.text = map['no_telpon'];
        if (role.text == "petani") {
          noRekening.text = map['no_rekening'];
        }
        foto.text = map['foto'];
      }
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }

  Future<String> clearData() async {
    try {
      username.text = "";
      email.text = "";
      nama.text = "";
      noTelpon.text = "";
      noRekening.text = "";
      alamat.text = "";
      return "sukses";
    } catch (e) {
      return "gagal";
    }
  }

  updateData(String id, XFile? image) async {
    try {
      print("disini?");
      var request = http.MultipartRequest(
        'POST',
        Uri.tryParse('${Api().baseURL}/account/ubah/$id')!,
      );
      print("sukses");
      var map = <String, dynamic>{};
      map['nama'] = nama.text;
      map['username'] = username.text;
      map['email'] = email.text;
      map['alamat'] = alamat.text;
      map['no_telpon'] = noTelpon.text;
      if (role.text == "petani") {
        map['no_rekening'] = noRekening.text;
      }

      map['role'] = role.text;

      // Menambahkan data string ke dalam request
      request.fields['nama'] = nama.text;
      request.fields['username'] = username.text;
      request.fields['email'] = email.text;
      request.fields['alamat'] = alamat.text;
      request.fields['no_telpon'] = noTelpon.text;
      if (role.text == "petani") {
        request.fields['no_rekening'] = noRekening.text;
      }
      request.fields['role'] = role.text;
      print(id);
      map.forEach((key, value) {
        request.fields[key] = value;
      });

      // split gambar
      var fotoLama = foto.text.split('/').last;
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
      if (response.statusCode == 200) {
      } else {}
    } catch (e) {
      Get.snackbar("Gagal", e.toString());
    } finally {
      getData(auth.box.read("id_user"));
    }
  }
}
