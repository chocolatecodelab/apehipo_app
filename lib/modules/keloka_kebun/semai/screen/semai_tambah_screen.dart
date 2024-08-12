import 'dart:io';

import '../controller/semai_controller.dart';
import '../model/semai_model.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/button.dart';
import '../../widgets/text_field.dart';
import '../../../../widgets/colors.dart';
import '../../../../widgets/confirmation_dialog.dart';
import '../../../../widgets/success_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SemaiTambahScreen extends StatefulWidget {
  const SemaiTambahScreen({super.key});

  @override
  State<SemaiTambahScreen> createState() => _SemaiTambahScreenState();
}

class _SemaiTambahScreenState extends State<SemaiTambahScreen> {
  var controller = Get.put(SemaiController());
  XFile? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    setState(() {
      _selectedImage = pickedImage;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.clearData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarKelolaKebun(title: "Tambah"),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height -
                80 -
                MediaQuery.of(context).padding.top,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      getImage(),
                      SizedBox(
                        height: 30,
                      ),
                      TextFieldKelolaKebun(
                        label: "Nama Sayur",
                        controller: controller.namaSayur,
                        sufixText: null,
                        sufixIcon: null,
                        isNumber: false,
                        getDate: false,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFieldKelolaKebun(
                        label: "Tanggal",
                        controller: controller.tanggal,
                        sufixText: null,
                        sufixIcon: Icon(
                          Icons.date_range,
                          color: AppColors.primaryColor,
                        ),
                        isNumber: true,
                        getDate: true,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFieldKelolaKebun(
                        label: "Jumlah BIbit",
                        controller: controller.jumlahBibit,
                        sufixText: null,
                        sufixIcon: null,
                        isNumber: true,
                        getDate: false,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFieldKelolaKebun(
                        label: "Waktu Penyemaian",
                        controller: controller.waktuPenyemaian,
                        sufixText: "Hari",
                        sufixIcon: null,
                        isNumber: true,
                        getDate: false,
                      ),
                    ],
                  ),
                ),
                ButtonKelolaKebun(
                  textButton: "Tambah",
                  onTap: () async {
                    bool? confirmationResult = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ConfirmationDialog(
                            message: "Apakah anda yakin?");
                      },
                    );
                    if (confirmationResult == true) {
                      String hasil = await controller.sendData(_selectedImage);
                      if (hasil == "sukses") {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SuccessConfirmationDialog(
                                message: "Data berhasil ditambahkan",
                                icon: Icons.check_circle_outline);
                          },
                        );
                        Get.back();
                      } else {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SuccessConfirmationDialog(
                                message: "Data gagal ditambahkan",
                                icon: Icons.close_rounded);
                          },
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector getImage() {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.photo_library,
                    ),
                    title: Text('Pilih dari Galeri'),
                    onTap: () {
                      // Get.to(controller.sendData(ImageSource.gallery));
                      _pickImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text('Ambil Foto'),
                    onTap: () {
                      // Get.to(controller.sendData(ImageSource.camera));
                      _pickImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Center(
        child: Column(
          children: [
            Container(
              height: 110,
              width: 120,
              child: Center(
                child: _selectedImage == null
                    ? SvgPicture.asset("assets/icons/upload-icon.svg")
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(
                          File(
                            _selectedImage!.path,
                          ),
                          fit: BoxFit.cover,
                          width: 120,
                          height: 110,
                        ),
                      ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Upload Gambar",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
