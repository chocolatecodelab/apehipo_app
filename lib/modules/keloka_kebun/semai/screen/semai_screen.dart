import 'package:Apehipo/modules/notification/screen/notification_screen.dart';

import '../controller/semai_controller.dart';
import '../model/semai_model.dart';
import 'semai_edit_screen.dart';
import 'semai_tambah_screen.dart';
import 'semai_tanam_screen.dart';
import '../../widgets/search_bar.dart';
import '../../../../widgets/colors.dart';
import '../../../../widgets/confirmation_dialog.dart';
import '../../../../widgets/success_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SemaiScreen extends StatefulWidget {
  const SemaiScreen({super.key});

  @override
  State<SemaiScreen> createState() => _SemaiScreenState();
}

class _SemaiScreenState extends State<SemaiScreen> {
  GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  var controller = Get.put(SemaiController());
  int hariTersisa = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<void> refreshData() async {
    await controller.refresh(); // Panggil metode refresh dari controller
    // Untuk menghentikan indikator refresh, panggil setState
    if (mounted) {
      setState(() {
        // Ini akan menghentikan indikator refresh
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kelola Kebun",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        toolbarHeight: 80,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => NotificationScreen());
            },
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          )
        ],
      ),
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: RefreshIndicator(
          key: _refreshKey,
          onRefresh: () => refreshData(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                SearchBarKelolaKebun(
                  controller: controller.search,
                  onTap: () => controller.getSearch(),
                ),
                SizedBox(
                  height: 30,
                ),
                Obx(
                  () => controller.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : controller.dataSemaiList!.isEmpty
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 200,
                                ),
                                Center(
                                  child: Text(
                                    "Tidak ada data",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            )
                          : _cardItem(
                              controller.dataSemaiList!,
                            ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _floatingButton(),
    );
  }

  FloatingActionButton _floatingButton() {
    return FloatingActionButton(
      onPressed: () {
        Get.to(() => SemaiTambahScreen());
      },
      tooltip: "Tambah",
      child: Icon(
        Icons.add,
        color: AppColors.primaryColor,
      ),
      backgroundColor: Colors.white,
      shape: CircleBorder(),
    );
  }

  ListView _cardItem(List<SemaiModel> items) {
    return ListView.separated(
      itemBuilder: (context, index) {
        var semai = items[index];
        final dateString = DateFormat('yyyy-MM-dd').parse(semai.tanggal);
        final difference = DateTime.now().difference(dateString);
        final dateFormatID = controller.formatTanggal(dateString);
        return Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18),
              padding: EdgeInsets.all(10),
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black26,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 5,
                            offset: Offset(0, 4)),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        semai.gambar,
                        fit: BoxFit.cover,
                        width: 120,
                        height: 110,
                      ),
                    ),
                  ),
                  Expanded(
                    // digunakan untuk memenuhi sisa ruang pada container
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 155,
                            child: Text(
                              // tanamModels[index].nama
                              semai.jenisSayur,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    // color: Colors.amber,
                                    border: Border.all(
                                      color: Color(0xFFD9D9D9),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      100,
                                    ),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${semai.jumlah}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Color(0xFF6F6F6F),
                                            height: 0,
                                          ),
                                        ),
                                        Text(
                                          "Bibit",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10,
                                            color: Color(0xFF6F6F6F),
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    // color: Colors.amber,
                                    border: Border.all(
                                      color: Color(0xFFD9D9D9),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      100,
                                    ),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${difference.inDays}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Color(0xFF6F6F6F),
                                            height: 0,
                                          ),
                                        ),
                                        Text(
                                          "Hari",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10,
                                            color: Color(0xFF6F6F6F),
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 70,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    // color: Colors.amber,
                                    border: Border(
                                      left: BorderSide(
                                        color: Color(0xFFD9D9D9),
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${dateFormatID.split(" ")[0]}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Color(0xFF6F6F6F),
                                            height: 0,
                                          ),
                                        ),
                                        Text(
                                          "${dateFormatID.split(" ")[1]}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Color(0xFF6F6F6F),
                                            height: 0,
                                          ),
                                        ),
                                        Text(
                                          "${dateFormatID.split(" ")[2]}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Color(0xFF6F6F6F),
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Get.to(() => SemaiEditScreen(items[index]));
                                },
                                child: Text(
                                  "Edit",
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  side:
                                      BorderSide(color: AppColors.primaryColor),
                                  minimumSize: Size(40, 30),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.to(() => SemaiTanamScreen(
                                      items[index], difference.inDays));
                                },
                                child: Text(
                                  "Tanam",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: AppColors.primaryColor,
                                  minimumSize: Size(40, 30),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -8,
              right: 12,
              child: IconButton(
                onPressed: () async {
                  bool? confirmationResult = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ConfirmationDialog(message: "Apakah anda yakin?");
                    },
                  );
                  if (confirmationResult == true) {
                    String hasil = await controller.deleteData(semai.id);
                    if (hasil == "sukses") {
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SuccessConfirmationDialog(
                              message: "Data berhasil dihapus",
                              icon: Icons.check_circle_outline);
                        },
                      );
                    } else {
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SuccessConfirmationDialog(
                              message: "Data gagal dihapus",
                              icon: Icons.close_rounded);
                        },
                      );
                    }
                  }
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red.withOpacity(0.8),
                  size: 18,
                ),
              ),
            )
          ],
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 20,
      ),
      itemCount: items.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
