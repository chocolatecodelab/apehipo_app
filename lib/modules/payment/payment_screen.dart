import 'dart:io';

import 'package:Apehipo/modules/account/account_toko.dart';
import 'package:Apehipo/modules/order/order_controller.dart';
import 'package:Apehipo/modules/order/order_screen.dart';
import 'package:Apehipo/widgets/app_button.dart';
import 'package:Apehipo/widgets/app_text.dart';
import 'package:Apehipo/widgets/colors.dart';
import 'package:Apehipo/widgets/confirmation_dialog.dart';
import 'package:Apehipo/widgets/dynamic_button.dart';
import 'package:Apehipo/widgets/success_confirmation_dialog.dart';
import 'package:Apehipo/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PaymentScreen extends StatefulWidget {
  final String totalHarga;
  final String? buktiPembayaran;
  final String idOrder;
  const PaymentScreen(this.totalHarga, this.buktiPembayaran, this.idOrder,
      {super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  var controller = Get.put(OrderController());
  bool _isExpandedMethod1 = false;
  bool _isExpandedMethod2 = false;
  bool _isExpandedMethod3 = false;
  bool _isExpandedMethod4 = false;
  bool _isExpanded1 = false; // Variabel untuk mengontrol ekspansi panel
  bool _isExpanded2 = false;
  bool _isExpanded3 = false;
  bool _isExpanded4 = false;
  XFile? _selectedImage;
  final formFieldKey = GlobalKey<FormState>();

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    setState(() {
      _selectedImage = pickedImage;
    });
  }

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
  Widget build(BuildContext context, {Widget? trailingWidget}) {
    final String textBni = "1288333921";
    final String textDANAGOPAY = "+6285921357723";
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Pembayaran",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 5, bottom: 0),
          child: Column(
            children: [
              // Bagian Total Pembayaran
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        AppText(
                          text: "Total Pembayaran",
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        Spacer(),
                        AppText(
                          text: "Rp${widget.totalHarga}",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: AppColors.primaryColor,
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),

              // Bagian Informasi Pembayaran BNI
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isExpandedMethod1 = !_isExpandedMethod1;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(Icons.payment),
                          SizedBox(
                            width: 20,
                          ),
                          AppText(
                            text: "Bank BNI",
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            textAlign: TextAlign.end,
                          ),
                          Spacer(),
                          Icon(
                            _isExpandedMethod1
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    if (_isExpandedMethod1)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              "Nomor Rekening bersama",
                              style: TextStyle(fontSize: 18),
                            ),
                            subtitle: AppText(
                              text: "Atas nama: Sdri Tasyalia Fajrina",
                              fontSize: 14,
                              color: Color(0xff7C7C7C),
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                // Implementasikan aksi yang sesuai di sini
                              },
                              child: IconButton(
                                icon: Icon(Icons.copy),
                                onPressed: () {
                                  _copyToClipboard(textBni);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('Teks disalin ke clipboard.'),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  textBni,
                                  style: TextStyle(
                                      fontSize: 20,
                                      letterSpacing: 1.5,
                                      color: AppColors.primaryColor),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: AppText(
                                  text:
                                      "Proses verifikasi kurang dari 10 menit setelah pembayaran berhasil.",
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: AppText(
                                  text:
                                      "Setelah membayar, segera konfirmasi dengan menekan tombol konfirmasi pembayaran di bawah ini.",
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isExpanded1 = !_isExpanded1;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 10, top: 20, right: 0, bottom: 0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: AppText(
                                    text: "Petunjuk Transfer",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  _isExpanded1
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (_isExpanded1)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(thickness: 1, color: Colors.grey),
                              SizedBox(
                                height: 10,
                              ),
                              AppText(
                                text: "A. Petunjuk transfer (Via ATM)",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              AppText(
                                text:
                                    "1. Masukkan PIN ATM. Klik Transfer Klik ke rekening BNI. Tunggu proses transfer berlangsung. Ambil kartu ATM dan jangan tinggal di mesin",
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                              AppText(
                                text:
                                    "2. Masukkan nomor rekening BNI Masukkan nominal transfer BNI. Klik Ya di halaman konfirmasi.",
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                              AppText(
                                text:
                                    "3. Tunggu proses transfer berlangsung. Ambil kartu ATM dan jangan tinggal di mesin",
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              AppText(
                                text:
                                    "B. Petunjuk transfer (Via Mobile Banking)",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              AppText(
                                text:
                                    "1. Login ke BNI Mobile. Masukkan UserID dan MPIN.  Masukkan rekening tujuan. Masukkan nominal transfer BNI.",
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                              AppText(
                                text:
                                    "2. Klik menu Transfer. Klik Antar BNI. Tekan Input Baru. Masukkan rekening tujuan.",
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                              AppText(
                                text:
                                    "3. Masukkan nominal transfer BNI. Klik Selanjutnya. Masukkan password. Klik Lanjut",
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),

              // Bagian Informasi Pembayaran Dana
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isExpandedMethod2 = !_isExpandedMethod2;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(Icons.payment),
                          SizedBox(
                            width: 20,
                          ),
                          AppText(
                            text: "DANA",
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            textAlign: TextAlign.end,
                          ),
                          Spacer(),
                          Icon(
                            _isExpandedMethod2
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    if (_isExpandedMethod2)
                      Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              "Nomor DANA",
                              style: TextStyle(fontSize: 18),
                            ),
                            subtitle: AppText(
                              text: "Atas nama: Sdri Tasyalia Fajrina",
                              fontSize: 14,
                              color: Color(0xff7C7C7C),
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                // Implementasikan aksi yang sesuai di sini
                              },
                              child: IconButton(
                                icon: Icon(Icons.copy),
                                onPressed: () {
                                  _copyToClipboard(textDANAGOPAY);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('Teks disalin ke clipboard.'),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  textDANAGOPAY,
                                  style: TextStyle(
                                      fontSize: 20,
                                      letterSpacing: 1.5,
                                      color: AppColors.primaryColor),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: AppText(
                                  text:
                                      "Proses verifikasi kurang dari 10 menit setelah pembayaran berhasil.",
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: AppText(
                                  text:
                                      "Setelah membayar, segera konfirmasi dengan menekan tombol konfirmasi pembayaran di bawah ini.",
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isExpanded2 = !_isExpanded2;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 10, top: 20, right: 0, bottom: 0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: AppText(
                                    text: "Petunjuk Transfer",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  _isExpanded2
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (_isExpanded2)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(thickness: 1, color: Colors.grey),
                              SizedBox(
                                height: 10,
                              ),
                              AppText(
                                text: "Petunjuk transfer:",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              AppText(
                                text:
                                    "1. Buka aplikasi DANA dan tap “Kirim”. Pilih opsi “Kirim ke Teman”. ",
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                              AppText(
                                text:
                                    "2. Masukkan nomor rekening tujuan/nomor HP dan nominal yang akan Anda kirimkan.",
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                              AppText(
                                text:
                                    "3. Pilih metode pembayaran dengan menggunakan Saldo DANA. Pastikan nomor dan jumlah transfer sudah sesuai.",
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),

              // Bagian informasi GoPay
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isExpandedMethod3 = !_isExpandedMethod3;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(Icons.payment),
                          SizedBox(
                            width: 20,
                          ),
                          AppText(
                            text: "GoPay",
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            textAlign: TextAlign.end,
                          ),
                          Spacer(),
                          Icon(
                            _isExpandedMethod3
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    if (_isExpandedMethod3)
                      Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              "Nomor GoPay",
                              style: TextStyle(fontSize: 18),
                            ),
                            subtitle: AppText(
                              text: "Atas nama: Sdri Tasyalia Fajrina",
                              fontSize: 14,
                              color: Color(0xff7C7C7C),
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                // Implementasikan aksi yang sesuai di sini
                              },
                              child: IconButton(
                                icon: Icon(Icons.copy),
                                onPressed: () {
                                  _copyToClipboard(textDANAGOPAY);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('Teks disalin ke clipboard.'),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  textDANAGOPAY,
                                  style: TextStyle(
                                      fontSize: 20,
                                      letterSpacing: 1.5,
                                      color: AppColors.primaryColor),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: AppText(
                                  text:
                                      "Proses verifikasi kurang dari 10 menit setelah pembayaran berhasil.",
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: AppText(
                                  text:
                                      "Setelah membayar, segera konfirmasi dengan menekan tombol konfirmasi pembayaran di bawah ini.",
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isExpanded3 = !_isExpanded3;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 10, top: 20, right: 0, bottom: 0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: AppText(
                                    text: "Petunjuk Transfer",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  _isExpanded3
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (_isExpanded3)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(thickness: 1, color: Colors.grey),
                              SizedBox(
                                height: 10,
                              ),
                              AppText(
                                text: "Petunjuk transfer",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              AppText(
                                text:
                                    "1. Buka aplikasi Gojek. Klik 'Bayar/Pay' pada halaman utama aplikasi. ",
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                              AppText(
                                text:
                                    "2. Ketikkan nama atau nomor HP teman kamu untuk kirim saldo GoPay, atau bisa langsung pilih dari daftar pilihan kontak teman GoPay kamu.",
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                              AppText(
                                text:
                                    "3. Masukkan jumlah yang ingin ditransfer. Klik 'Konfirmasi' dan Pay untuk melanjutkan.",
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),

              // Batas bukti pembayaran
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isExpandedMethod4 = !_isExpandedMethod4;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(Icons.camera_alt_outlined),
                          SizedBox(
                            width: 20,
                          ),
                          AppText(
                            text: "Foto Bukti Pembayaran",
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            textAlign: TextAlign.end,
                          ),
                          Spacer(),
                          Icon(
                            _isExpandedMethod4
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    if (_isExpandedMethod4)
                      Column(
                        children: [
                          getImageBukti(_selectedImage, widget.buktiPembayaran),
                          SizedBox(
                            height: 10,
                          ),
                          if (_selectedImage != null)
                            DynamicButtonWidget(
                              label: "Simpan gambar",
                              textColor: Colors.white,
                              backgroundColor: AppColors.darkGrey,
                              iconData: Icons.add,
                              onPressed: () async {
                                bool? confirmationResult = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ConfirmationDialog(
                                        message:
                                            "Apakah anda yakin ingin mengirim bukti pembayaran ini?");
                                  },
                                );
                                if (confirmationResult == true) {
                                  String hasil = await controller.kirimBukti(
                                      widget.idOrder, _selectedImage);
                                  if (hasil == "sukses") {
                                    await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SuccessConfirmationDialog(
                                              message:
                                                  "Anda berhasil menambahkan gambar",
                                              icon: Icons.check_circle_outline);
                                        });
                                    Get.back();
                                    refreshData();
                                  } else if (hasil == "gagal") {
                                    await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SuccessConfirmationDialog(
                                              message:
                                                  "Gagal menambahkan gambar",
                                              icon: Icons.close_rounded);
                                        });
                                  }
                                }
                              },
                            ),
                          SizedBox(
                            height: 15,
                          ),
                          if (_selectedImage == null)
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                child: ElevatedButton(
                                  onPressed: _selectedImage == null
                                      ? () {
                                          print(widget.buktiPembayaran);
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return SafeArea(
                                                child: Form(
                                                  key: formFieldKey,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      ListTile(
                                                        leading: Icon(Icons
                                                            .photo_library),
                                                        title: Text(
                                                            'Pilih dari Galeri'),
                                                        onTap: () {
                                                          _pickImage(ImageSource
                                                              .gallery);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      ListTile(
                                                        leading: Icon(
                                                            Icons.camera_alt),
                                                        title:
                                                            Text('Ambil Foto'),
                                                        onTap: () {
                                                          _pickImage(ImageSource
                                                              .camera);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        }
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    visualDensity: VisualDensity.compact,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    elevation: 0,
                                    backgroundColor: _selectedImage == null
                                        ? AppColors.primaryColor
                                        : AppColors.darkGrey,
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontFamily: gilroyFontFamily,
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 24),
                                    maximumSize: Size(350, 60),
                                  ),
                                  child: Stack(
                                    fit: StackFit.passthrough,
                                    children: <Widget>[
                                      Center(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            _selectedImage == null
                                                ? "Konfirmasi Pembayaran"
                                                : "Bukti Pembayaran diproses",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Icon(Icons.add_a_photo_outlined)
                                        ],
                                      )),
                                      if (trailingWidget != null)
                                        Positioned(
                                          top: 0,
                                          right: 25,
                                          child: trailingWidget,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageBukti(XFile? _selectedImage, String? foto) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
        child: _selectedImage == null
            ? Image.network(foto!)
            : Image.file(File(_selectedImage.path)),
      ),
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}
