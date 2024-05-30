import 'package:Apehipo/modules/keloka_kebun/report/controller/report_controller.dart';
import 'package:Apehipo/modules/keloka_kebun/report/model/data_sayur_model.dart';
import 'package:Apehipo/modules/keloka_kebun/report/model/report_model.dart';
import 'package:Apehipo/modules/keloka_kebun/widgets/search_bar.dart';
import 'package:Apehipo/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  var controller = Get.put(ReportController());

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
            child: Obx(
              () => controller.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : controller.dataSayurList!.isEmpty
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
                      : Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            dataSayur(),
                            SizedBox(
                              height: 15,
                            ),
                            Divider(),
                            SizedBox(
                              height: 20,
                            ),
                            dataBibit(controller.dataSayurList!),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
            ),
          ),
        ),
      ),
    );
  }

  ListView dataBibit(List<DataSayurModel> items) {
    return ListView.separated(
      itemBuilder: (context, index) {
        var sayur = items[index];
        int minTanam =
            int.parse(sayur.jumlahSemai) - int.parse(sayur.jumlahTanam);
        int minPanen =
            int.parse(sayur.jumlahTanam) - int.parse(sayur.jumlahPanen);
        print(sayur.tanggalPanen);
        return Container(
          height: 150,
          margin: EdgeInsets.symmetric(horizontal: 25),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sayur.namaSayur,
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                  Text(
                    sayur.tanggalPanen == "0000-00-00"
                        ? "Belum dipanen"
                        : sayur.tanggalPanen,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Semai  : ${sayur.jumlahSemai} Bibit",
                  ),
                  Text(
                    sayur.tanggalSemai,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tanam : ${sayur.jumlahTanam} Bibit",
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    minTanam != 0 ? "-${minTanam}" : "",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Panen  : ${sayur.jumlahPanen} Sayur",
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    minPanen != 0 ? "-${minPanen}" : "",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ],
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

  Container dataSayur() {
    return Container(
      height: 170,
      width: double.infinity,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(
        horizontal: 25,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white),
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Total Sayur Disemai  : ${controller.report.value.totalSayurDisemai}"),
            Text(
                "Total Sayur Ditanam : ${controller.report.value.totalSayurDitanam}"),
            Text(
                "Total Panen Sayur     : ${controller.report.value.totalSayurDipanen}"),
            Text(
                "Jumlah Sayur             : ${controller.report.value.jumlahSayur}"),
          ],
        ),
      ),
    );
  }
}
