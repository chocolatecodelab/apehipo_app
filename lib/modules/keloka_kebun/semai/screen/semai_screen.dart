import 'package:Apehipo/modules/keloka_kebun/semai/controller/semai_controller.dart';
import 'package:Apehipo/modules/keloka_kebun/semai/model/semai_model.dart';
import 'package:Apehipo/modules/keloka_kebun/semai/screen/semai_edit_screen.dart';
import 'package:Apehipo/modules/keloka_kebun/semai/screen/semai_tambah_screen.dart';
import 'package:Apehipo/modules/keloka_kebun/semai/screen/semai_tanam_screen.dart';
import 'package:Apehipo/modules/keloka_kebun/widgets/search_bar.dart';
import 'package:Apehipo/widgets/colors.dart';
import 'package:Apehipo/widgets/confirmation_dialog.dart';
import 'package:Apehipo/widgets/success_confirmation_dialog.dart';
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
        int waktu = int.parse(semai.waktu) + 1;
        DateTime target = DateTime.now().add(Duration(days: waktu));
        hariTersisa = target.difference(DateTime.now()).inDays;
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
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            // {DateFormat.yMMMMd().format(tanamModels[index].tanggal)}
                            "Tanggal Disemai : ${semai.tanggal}",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            // {tanamModels[index].bibit}
                            "${semai.jumlah} Bibit",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            hariTersisa == 0
                                ? "Ditanam hari ini"
                                : "Ditanam dalam ${hariTersisa} hari",
                            // tanamModels[index].hari == 0
                            //     ? "Ditanam hari ini"
                            //     : "Ditanam dalam ${tanamModels[index].hari} hari"
                            style: TextStyle(
                              fontSize: 10,
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
                                  backgroundColor: hariTersisa < 0
                                      ? Color(0xFFEE4646)
                                      : hariTersisa == 0
                                          ? Color(0xFFEFCE5A)
                                          : AppColors.primaryColor,
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
