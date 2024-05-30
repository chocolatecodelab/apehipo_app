import 'package:Apehipo/modules/keloka_kebun/tanam/controller/tanam_controller.dart';
import 'package:Apehipo/modules/keloka_kebun/tanam/model/tanam_model.dart';
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

class TanamPanenScreen extends StatefulWidget {
  final TanamModel tanamItem;
  final difference;
  const TanamPanenScreen(this.tanamItem, this.difference);

  @override
  State<TanamPanenScreen> createState() => _TanamPanenScreenState();
}

class _TanamPanenScreenState extends State<TanamPanenScreen> {
  var controller = Get.put(TanamController());
  int jumlahTanaman = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.clearData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarKelolaKebun(title: "Panen"),
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
                        label: "Tanggal Panen",
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
                        height: 30,
                      ),
                      JumlahTanaman(),
                      SizedBox(
                        height: 30,
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
                  textButton: "Panen",
                  onTap: () async {
                    bool? confirmationResult = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ConfirmationDialog(
                            message: "Apakah anda yakin?");
                      },
                    );
                    if (confirmationResult == true) {
                      print(widget.tanamItem.jumlah);
                      print(controller.jumlah.text);
                      print(
                          "hasil : ${controller.jumlah.text.compareTo(widget.tanamItem.jumlah) <= 0}");
                      if (controller.jumlah.text
                              .compareTo(widget.tanamItem.jumlah) <=
                          0) {
                        String hasil =
                            await controller.toPanen(widget.tanamItem.id);
                        if (hasil == "sukses") {
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SuccessConfirmationDialog(
                                  message: "Berhasil dipanen",
                                  icon: Icons.check_circle_outline);
                            },
                          );
                          Get.back();
                        } else {
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SuccessConfirmationDialog(
                                  message: "Gagal dipanen",
                                  icon: Icons.close_rounded);
                            },
                          );
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SuccessConfirmationDialog(
                                message: "Gagal dipanen",
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
              widget.tanamItem.gambar,
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
                    widget.tanamItem.namaSayur,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Tanggal ditanam: ${widget.tanamItem.tanggal}"),
                  Text(widget.difference == 0
                      ? "Ditanam hari ini"
                      : "Telah ditanam selama ${widget.difference} hari"),
                  Text("${widget.tanamItem.jumlah} Bibit"),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Row JumlahTanaman() {
    return Row(
      children: [
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.6,
          margin: EdgeInsets.only(left: 25),
          child: TextField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
            ],
            controller: controller.jumlah,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(15),
              ),
              contentPadding: EdgeInsets.all(16),
              labelText: "Jumlah Tanaman",
              labelStyle: TextStyle(
                color: Color(0xFFC1C1C1),
              ),
              floatingLabelStyle: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            _decrementJumlahTanaman();
          },
          icon: Icon(Icons.remove_circle_outline),
          color: AppColors.primaryColor,
          iconSize: 30,
        ),
        IconButton(
          onPressed: () {
            _incrementJumlahTanaman();
          },
          icon: Icon(Icons.add_circle_outline),
          color: AppColors.primaryColor,
          iconSize: 30,
        ),
      ],
    );
  }

  void _incrementJumlahTanaman() {
    setState(() {
      if (controller.jumlah.text.isEmpty) {
        controller.jumlah.text = '0';
      }
      if (controller.jumlah.text.compareTo(widget.tanamItem.jumlah) < 0) {
        jumlahTanaman = int.parse(controller.jumlah.text);
        jumlahTanaman++;
        controller.jumlah.text = jumlahTanaman.toString();
      }
    });
  }

  void _decrementJumlahTanaman() {
    if (jumlahTanaman > 1) {
      setState(
        () {
          jumlahTanaman = int.parse(controller.jumlah.text);
          jumlahTanaman--;
          controller.jumlah.text = jumlahTanaman.toString();
        },
      );
    }
  }
}
