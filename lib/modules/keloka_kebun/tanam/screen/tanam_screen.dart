import 'package:Apehipo/modules/keloka_kebun/tanam/controller/tanam_controller.dart';
import 'package:Apehipo/modules/keloka_kebun/tanam/model/tanam_model.dart';
import 'package:Apehipo/modules/keloka_kebun/tanam/screen/tanam_panen_screen.dart';
import 'package:Apehipo/modules/keloka_kebun/widgets/search_bar.dart';
import 'package:Apehipo/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TanamScreen extends StatefulWidget {
  const TanamScreen({super.key});

  @override
  State<TanamScreen> createState() => _TanamScreenState();
}

class _TanamScreenState extends State<TanamScreen> {
  GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  var controller = Get.put(TanamController());
  int hasiTersisa = 0;

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
                      : controller.dataTanamList!.isEmpty
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
                          : cardItem(
                              controller.dataTanamList!,
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
    );
  }

  ListView cardItem(List<TanamModel> items) {
    return ListView.separated(
      itemBuilder: (context, index) {
        var tanam = items[index];
        final dateString = DateFormat('yyyy-MM-dd').parse(tanam.tanggal);
        final difference = DateTime.now().difference(dateString);
        int waktu = int.parse(tanam.masaTanam) + 1;
        DateTime target = DateTime.now().add(Duration(days: waktu));
        hasiTersisa = target.difference(DateTime.now()).inDays;
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 18),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 25),
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
                    tanam.gambar,
                    fit: BoxFit.cover,
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
                      Text(
                        tanam.namaSayur,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        difference.inDays == 0
                            ? "Ditanam hari ini"
                            : "Ditanam ${difference.inDays} hari yang lalu",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        hasiTersisa == 0
                            ? "Panen hari ini"
                            : "Panen dalam ${hasiTersisa} hari",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        "${tanam.jumlah} Bibit",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => TanamPanenScreen(
                                items[index], difference.inDays));
                          },
                          child: Text(
                            "Panen",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: BorderSide(
                              color: hasiTersisa < 0
                                  ? Color(0xFFEE4646)
                                  : hasiTersisa == 0
                                      ? Color(0xFFEFCE5A)
                                      : AppColors.primaryColor,
                            ),
                            minimumSize: Size(double.infinity, 30),
                            backgroundColor: hasiTersisa < 0
                                ? Color(0xFFEE4646)
                                : hasiTersisa == 0
                                    ? Color(0xFFEFCE5A)
                                    : AppColors.primaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
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
