import 'package:Apehipo/modules/notification/screen/notification_screen.dart';

import '../controller/tanam_controller.dart';
import '../model/tanam_model.dart';
import '../../monitoring/screen/monitoring_screen.dart';
import 'tanam_panen_screen.dart';
import '../../widgets/search_bar.dart';
import '../../../../widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xFFD9D9D9), width: 1),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "72",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Color(0xFF6F6F6F),
                                          height: 0),
                                    ),
                                    Text(
                                      "Bibit",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: Color(0xFF6F6F6F),
                                          height: 0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xFFD9D9D9), width: 1),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "0",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Color(0xFF6F6F6F),
                                          height: 0),
                                    ),
                                    Text(
                                      "Bibit",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: Color(0xFF6F6F6F),
                                          height: 0),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "09",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Color(0xFF6F6F6F),
                                        height: 0,
                                      ),
                                    ),
                                    Text(
                                      "Februari",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Color(0xFF6F6F6F),
                                        height: 0,
                                      ),
                                    ),
                                    Text(
                                      "2024",
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
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "07/02/2024",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  Text(
                                    "Semai",
                                    style: TextStyle(
                                      color: Color(0xFFFEBE54),
                                      fontSize: 10,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
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
                            ),
                          ],
                        ),
                      ),
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
