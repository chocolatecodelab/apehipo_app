import 'package:Apehipo/modules/keloka_kebun/monitoring/screen/history_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../controllers/rumah_controller.dart';
import '../model/monitoring_model.dart';
import '../model/rumah_model.dart';
import 'monitoring_edit_pph_screen.dart';
import 'monitoring_tambah_pph_screen.dart';
import 'monitoring_edit_screen.dart';
import 'monitoring_tambah_screen.dart';
import '../../../../widgets/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MonitoringScreen extends StatefulWidget {
  @override
  State<MonitoringScreen> createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> {
  var controller = Get.put(RumahController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // controller.refreshDataMonitoring();
    // print("tanggal controller : " + controllerMonitoring.tanggal.value);
    // controller.printID();
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
              Get.to(() => HistoryScreen());
            },
            icon: SvgPicture.asset(
              "assets/icons/history-icon.svg",
              height: 20,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            // Center(
            //   child: Text(
            //     _selectedDay == null
            //         ? "Tanggal ${_focusedDay.toString().split(" ")[0]}"
            //         : "Tanggal : ${_selectedDay!.toIso8601String().split("T")[0]}",
            //   ),
            // ),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                  () => controller.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        )
                      : controller.dataRumahList.isEmpty
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 70,
                                ),
                                Center(
                                  child: Text(
                                    "Tidak ada data",
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                )
                              ],
                            )
                          : cardItem(controller.dataRumahList,
                              controller.dataMonitoringList),
                ),
              ),
            ),
            // cardItem(controller.dataTanamList!)
          ],
        ),
      ),
      floatingActionButton: _floatingButton(),
    );
  }

  FloatingActionButton _floatingButton() {
    return FloatingActionButton(
      onPressed: () {
        Get.to(() => MonitoringTambahScreen());
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

  ListView cardItem(
      List<RumahModel> items, List<MonitoringModel> itemsMonitoring) {
    // for (var i = 0; i < items.length; i++) {
    //   controllerMonitoring.idRumah.add(items[i].idRumah);

    //   print(
    //       "Id ke $i ${items[i].idRumah} PPM : ${controllerMonitoring.dataMonitoringList[i].ppm}");
    // }
    return ListView.separated(
      itemBuilder: (context, index) {
        var rumah = items[index];
        var monitoring = itemsMonitoring[index];
        print("ID RUMAH MONITORING KE $index: ${monitoring.idMonitoring}");
        // controllerMonitoring.getAllData(rumah.idRumah);
        // controllerMonitoring.idRumah.add(rumah.idRumah);
        // // print(rumah.idRumah);
        // var monitoring = itemsMonitoring.firstWhere(
        //   (element) => element.idRumah == rumah.idRumah,
        // );
        // print(monitoring.idMonitoring);
        return Stack(
          children: [
            GestureDetector(
              onTap: () => Get.to(
                () => monitoring.ppm != "-"
                    ? MonitoringEditPph(monitoring, rumah)
                    : MonitoringTambahPph(rumah),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 18),
                padding: EdgeInsets.all(10),
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.primaryColor,
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      width: 110,
                      height: 120,
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
                          rumah.gambar,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      // digunakan untuk memenuhi sisa ruang pada container
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 155,
                              child: Text(
                                // tanamModels[index].nama
                                "${rumah.namaRumah}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              // {DateFormat.yMMMMd().format(tanamModels[index].tanggal)}
                              "${rumah.kapasitas} Tanaman",
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                            Text(
                              // {tanamModels[index].bibit}
                              "${rumah.deskripsi}",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Container(
                              height: 45,
                              padding: EdgeInsets.all(3),
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Ppm : ${monitoring.ppm}",
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    "Ph : ${monitoring.ph}",
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 13,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 15,
              child: IconButton(
                onPressed: () {
                  Get.to(() => MonitoringEditScreen(items[index]));
                },
                icon: Icon(
                  Icons.edit_square,
                  color: Colors.white,
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