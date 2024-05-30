import 'package:Apehipo/modules/keloka_kebun/semai/controller/semai_controller.dart';
import 'package:Apehipo/modules/keloka_kebun/semai/model/semai_model.dart';
import 'package:Apehipo/modules/keloka_kebun/widgets/app_bar.dart';
import 'package:Apehipo/modules/keloka_kebun/widgets/button.dart';
import 'package:Apehipo/modules/keloka_kebun/widgets/text_field.dart';
import 'package:Apehipo/modules/keloka_kebun/widgets/text_field_keterangan.dart';
import 'package:Apehipo/widgets/colors.dart';
import 'package:Apehipo/widgets/confirmation_dialog.dart';
import 'package:Apehipo/widgets/success_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SemaiTanamScreen extends StatefulWidget {
  final SemaiModel semaiItem;
  final difference;
  const SemaiTanamScreen(this.semaiItem, this.difference);

  @override
  State<SemaiTanamScreen> createState() => _SemaiTanamScreenState();
}

class _SemaiTanamScreenState extends State<SemaiTanamScreen> {
  var controller = Get.put(SemaiController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.clearData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarKelolaKebun(title: "Tanam"),
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
                      dataSayur(),
                      SizedBox(
                        height: 30,
                      ),
                      TextFieldKelolaKebun(
                        label: "Tanggal Tanam",
                        controller: controller.tanggal,
                        sufixText: null,
                        sufixIcon: Icon(
                          Icons.date_range,
                          color: AppColors.primaryColor,
                        ),
                        isNumber: true,
                        getDate: true,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFieldKelolaKebun(
                        label: "Jumlah Bibit",
                        controller: controller.jumlahBibit,
                        sufixText: null,
                        sufixIcon: null,
                        isNumber: true,
                        getDate: false,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFieldKelolaKebun(
                        label: "Masa Tanam",
                        controller: controller.masaTanam,
                        sufixText: "Hari",
                        sufixIcon: null,
                        isNumber: true,
                        getDate: false,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFieldKeterangan(
                        controller: controller.keterangan,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
                ButtonKelolaKebun(
                  textButton: "Tanam",
                  onTap: () async {
                    bool? confirmationResult = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ConfirmationDialog(
                            message: "Apakah anda yakin?");
                      },
                    );
                    if (confirmationResult == true) {
                      if (controller.jumlahBibit.text
                              .compareTo(widget.semaiItem.jumlah) <=
                          0) {
                        String hasil =
                            await controller.toTanam(widget.semaiItem.id);
                        if (hasil == "sukses") {
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SuccessConfirmationDialog(
                                  message: "Berhasil ditanam",
                                  icon: Icons.check_circle_outline);
                            },
                          );
                          Get.back();
                        } else {
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SuccessConfirmationDialog(
                                  message: "Gagal ditanam",
                                  icon: Icons.close_rounded);
                            },
                          );
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SuccessConfirmationDialog(
                                message: "Gagal ditanam",
                                icon: Icons.close_rounded);
                          },
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row dataSayur() {
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
              widget.semaiItem.gambar,
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
                    widget.semaiItem.jenisSayur,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Tanggal Disemai: ${widget.semaiItem.tanggal}"),
                  Text(widget.difference == 0
                      ? "Disemai hari ini"
                      : "Telah disemai selama ${widget.difference} hari"),
                  Text("${widget.semaiItem.jumlah} Bibit"),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
