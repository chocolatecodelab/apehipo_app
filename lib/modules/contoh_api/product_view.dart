import 'package:apehipo_app/modules/contoh_api/product_add.dart';
import 'package:apehipo_app/modules/contoh_api/product_ubah.dart';
import 'package:apehipo_app/widgets/confirmation_dialog.dart';
import 'package:apehipo_app/widgets/success_confirmation_dialog.dart';

import 'product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductView extends StatefulWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(ProductAdd());
                  },
                  child: Text("Add"),
                ),
                Obx(
                  () => controller.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : controller.dataList!.isEmpty
                          ? Center(child: Text('Tidak ada data.'))
                          : ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: controller.dataList!.length,
                              itemBuilder: (ctx, i) {
                                String id = controller.dataList![i].kode;
                                String title = controller.dataList![i].nama;
                                return InkWell(
                                  onTap: () {
                                    controller.showData(id);
                                  },
                                  child: Column(
                                    children: [
                                      Card(
                                        margin: const EdgeInsets.all(10),
                                        elevation: 10,
                                        child: ListTile(
                                          title: Text(id + ": " + title),
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.to(ProductUbah(id, title));
                                            },
                                            child: Text("Update data"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () async {
                                              bool? confirmationResult =
                                                  await showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return ConfirmationDialog(
                                                      message:
                                                          "Apakah anda yakin ingin menyimpan perubahan?");
                                                },
                                              );
                                              if (confirmationResult == true) {
                                                SuccessConfirmationDialog(
                                                    message:
                                                        "Anda berhasil menghapus data");
                                                controller.deleteData(id);
                                              } else {
                                                print("Gagal");
                                              }
                                            },
                                            child: Text("Delete data"),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
