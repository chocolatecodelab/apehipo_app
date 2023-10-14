import 'package:Apehipo/modules/account/account_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreviewImage extends StatefulWidget {
  @override
  State<PreviewImage> createState() => _PreviewImageState();
}

class _PreviewImageState extends State<PreviewImage> {
  var controller = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Preview Modal Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Tampilkan modal saat tombol ditekan
            showModal(context);
          },
          child: Text('Tampilkan Gambar'),
        ),
      ),
    );
  }

  void showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(controller.foto.text),
              ElevatedButton(
                onPressed: () {
                  // Tutup modal saat tombol ditekan
                  Navigator.of(context).pop();
                },
                child: Text('Tutup'),
              ),
            ],
          ),
        );
      },
    );
  }
}
