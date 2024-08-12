import '../controllers/rumah_controller.dart';
import '../model/rumah_model.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/button.dart';
import '../../widgets/text_field.dart';
import '../../../../widgets/colors.dart';
import '../../../../widgets/confirmation_dialog.dart';
import '../../../../widgets/success_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MonitoringTambahPph extends StatefulWidget {
  final RumahModel rumahItem;

  MonitoringTambahPph(this.rumahItem);

  @override
  State<MonitoringTambahPph> createState() => _MonitoringEditPphState();
}

class _MonitoringEditPphState extends State<MonitoringTambahPph> {
  var controller = Get.put(RumahController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("ID RUMAH : ${widget.rumahItem.idRumah}");
    controller.clearDataMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarKelolaKebun(title: "Tambah"),
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
                      dataRumah(),
                      SizedBox(
                        height: 30,
                      ),
                      TextFieldKelolaKebun(
                        label: "Ppm",
                        controller: controller.ppmController,
                        sufixText: null,
                        sufixIcon: null,
                        isNumber: true,
                        getDate: false,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFieldKelolaKebun(
                          label: "Ph",
                          controller: controller.phController,
                          sufixText: null,
                          sufixIcon: null,
                          isNumber: true,
                          getDate: false),
                    ],
                  ),
                ),
                ButtonKelolaKebun(
                  textButton: "Tambah",
                  onTap: () async {
                    bool? confimationResult = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ConfirmationDialog(
                            message: "Apakah anda yakin?");
                      },
                    );
                    if (confimationResult == true) {
                      String hasil = await controller
                          .sendDataMonitoring(widget.rumahItem.idRumah);
                      if (hasil == "sukses") {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SuccessConfirmationDialog(
                                message: "Data berhasil ditambahkan",
                                icon: Icons.check_circle_outline);
                          },
                        );
                        Get.back();
                      } else {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SuccessConfirmationDialog(
                                message: "Data gagal ditambahkan",
                                icon: Icons.close_rounded);
                          },
                        );
                      }
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row dataRumah() {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 10, left: 25),
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                spreadRadius: 0,
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              widget.rumahItem.gambar,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.only(right: 25),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: DefaultTextStyle(
              style: TextStyle(color: Colors.white, fontSize: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.rumahItem.namaRumah,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("${widget.rumahItem.kapasitas} Tanaman"),
                  Text(
                    widget.rumahItem.deskripsi,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
