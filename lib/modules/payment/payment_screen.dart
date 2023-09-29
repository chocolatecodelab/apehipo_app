import 'package:apehipo_app/modules/order/order_screen.dart';
import 'package:apehipo_app/widgets/app_button.dart';
import 'package:apehipo_app/widgets/app_text.dart';
import 'package:apehipo_app/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatefulWidget {
  final String totalHarga;
  const PaymentScreen(this.totalHarga, {super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _isExpandedMethod1 = false;
  bool _isExpandedMethod2 = false;
  bool _isExpandedMethod3 = false;
  bool _isExpanded1 = false; // Variabel untuk mengontrol ekspansi panel
  bool _isExpanded2 = false;
  bool _isExpanded3 = false;

  @override
  Widget build(BuildContext context) {
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
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        AppText(
                          text: "Batas Pembayaran",
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        Spacer(),
                        AppText(
                          text: "2 jam setelah order dibuat",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: AppColors.primaryColor,
                          textAlign: TextAlign.end,
                        ),
                      ],
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

              // Bagian Informasi Pembayaran Gopay
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
                                  _isExpanded1
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

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: AppButton(label: "Konfirmasi Pembayaran"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}
