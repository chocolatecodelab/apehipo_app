import '../controller/report_controller.dart';
import '../model/data_sayur_model.dart';
import '../../semai/controller/semai_controller.dart';
import '../../semai/model/semai_model.dart';
import '../../../../widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  var semaiController = Get.put(SemaiController());

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
                            dataBibit(
                              controller.dataSayurList!,
                            ),
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

  ListView dataBibit(List<DataSayurModel> itemsSayur) {
    return ListView.separated(
      itemBuilder: (context, index) {
        var sayur = itemsSayur[index];
        int minTanam =
            int.parse(sayur.jumlahSemai) - int.parse(sayur.jumlahTanam);
        int minPanen =
            int.parse(sayur.jumlahTanam) - int.parse(sayur.jumlahPanen);
        print(sayur.tanggalPanen);
        return Container(
          height: 145,
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                width: 100,
                height: 100,
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
                    sayur.gambar,
                    fit: BoxFit.cover,
                    width: 120,
                    height: 110,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sayur.namaSayur,
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          sayur.tanggalPanen == "0000-00-00"
                              ? "Belum dipanen"
                              : sayur.tanggalPanen,
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: AppColors.primaryColor,
                      height: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Semai  : ${sayur.jumlahSemai} Bibit",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          sayur.tanggalSemai,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Tanam : ${sayur.jumlahTanam} Bibit",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          minTanam != 0 ? "(${minTanam} Bibit Gagal)" : "",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Panen  : ${sayur.jumlahPanen} Sayur",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          minPanen != 0 ? "(${minPanen} Sayur Rusak)" : "",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 20,
      ),
      itemCount: itemsSayur.length,
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
