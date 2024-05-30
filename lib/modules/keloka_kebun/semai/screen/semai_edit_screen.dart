import 'dart:io';

import 'package:Apehipo/modules/keloka_kebun/semai/controller/semai_controller.dart';
import 'package:Apehipo/modules/keloka_kebun/semai/model/semai_model.dart';
import 'package:Apehipo/modules/keloka_kebun/widgets/app_bar.dart';
import 'package:Apehipo/modules/keloka_kebun/widgets/button.dart';
import 'package:Apehipo/modules/keloka_kebun/widgets/text_field.dart';
import 'package:Apehipo/widgets/colors.dart';
import 'package:Apehipo/widgets/confirmation_dialog.dart';
import 'package:Apehipo/widgets/success_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SemaiEditScreen extends StatefulWidget {
  final SemaiModel semaiItem;

  const SemaiEditScreen(this.semaiItem);

  @override
  State<SemaiEditScreen> createState() => _SemaiEditScreenState();
}

class _SemaiEditScreenState extends State<SemaiEditScreen> {
  var controller = Get.find<SemaiController>();
  XFile? _selectedImage;

  @override
  void initState() {
    super.initState();
    controller.id.text = widget.semaiItem.id;
    controller.namaSayur.text = widget.semaiItem.jenisSayur;
    controller.tanggal.text = widget.semaiItem.tanggal;
    controller.jumlahBibit.text = widget.semaiItem.jumlah;
    controller.waktuPenyemaian.text = widget.semaiItem.waktu;
    controller.gambar.text = widget.semaiItem.gambar;
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    setState(() {
      _selectedImage = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarKelolaKebun(title: "Edit"),
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
                      )
                    ],
                  ),
                ),
                ButtonKelolaKebun(
                  textButton: "Simpan",
                  onTap: () async {
                    bool? confirmationResult = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ConfirmationDialog(
                            message: "Apakah anda yakin?");
                      },
                    );
                    if (confirmationResult == true) {
                      String hasil = await controller.updateData(
                          widget.semaiItem.id, _selectedImage);
                      if (hasil == "sukses") {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SuccessConfirmationDialog(
                                message: "Data berhasil diubah",
                                icon: Icons.check_circle_outline);
                          },
                        );
                        Get.back();
                      } else {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SuccessConfirmationDialog(
                                message: "Data gagal diubah",
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
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          widget.semaiItem.gambar,
                          fit: BoxFit.cover,
                          width: 120,
                          height: 110,
                        ),
                      )
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
