import 'package:apehipo_app/auth/auth_controller.dart';
import 'package:apehipo_app/modules/account/account_controller.dart';
import 'package:apehipo_app/modules/kelola_kebun/kelola_kebun_bottom.dart';
import 'package:apehipo_app/modules/notification/notification_screen.dart';
import 'package:apehipo_app/modules/order/order_screen.dart';
import 'package:apehipo_app/modules/transaction/transaction_screen.dart';
import 'package:apehipo_app/modules/transaction/transcation_screen_petani.dart';
import 'package:apehipo_app/widgets/confirmation_dialog_logout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:apehipo_app/widgets/app_text.dart';
import 'package:apehipo_app/widgets/column_with_seprator.dart';
import 'package:apehipo_app/modules/account/account_edit.dart';
import 'package:apehipo_app/modules/catalog/katalog_screen.dart';
import 'package:apehipo_app/modules/account/account_toko.dart';
import 'package:apehipo_app/widgets/colors.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import 'account_item.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var auth = Get.put(AuthController());
  var controller = Get.put(AccountController());

  void initState() {
    super.initState();

    // Set nilai awal _nameController jika widget.katalogItem tidak null
    if (controller.map['foto'] == null) {
      controller.isLoading(true);
    } else {
      controller.foto.text = controller.map['foto'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Obx(() => controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : controller.map.isEmpty
                        ? Center(child: Text("Tidak ada data"))
                        : ListTile(
                            leading: GestureDetector(
                              onTap: () {
                                showModal(context);
                              },
                              child: SizedBox(
                                width: 60,
                                height: 85,
                                child: getImageHeader(controller.foto.text),
                              ),
                            ),
                            title: AppText(
                              text: controller.nama.text,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            subtitle: AppText(
                              text: auth.box.read("role") == "petani"
                                  ? "Petani"
                                  : "Konsumen",
                              color: Color(0xff7C7C7C),
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            ),
                          )),
                SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    if (auth.box.read("role") == "petani") ...[
                      getHorizontalItemSlider(),
                      Divider(thickness: 1),
                    ],
                    ...getChildrenWithSeperator(
                      widgets: accountItems
                          .where((item) => shouldDisplay(item))
                          .map((e) {
                        return getAccountItemWidget(context, e);
                      }).toList(),
                      seperator: Divider(
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                logoutButton(context),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(controller.foto.text),
              ElevatedButton(
                onPressed: () {
                  // Tutup modal saat tombol ditekan
                  Navigator.of(context).pop();
                },
                child: Text('Tutup'),
              ),
            ],
          ),
        );
      },
    );
  }

  bool shouldDisplay(AccountItem item) {
    if (auth.box.read("role") == "petani") {
      if (item.label == "Transaksi" || item.label == "Status Pembelian") {
        return false;
      }
      return true;
    } else {
      if (item.label == "Transaksi Petani" ||
          item.label == "Edit Kebun" ||
          item.label == "Katalog") {
        return false;
      }
      return true;
    }
  }

  Widget getHorizontalItemSlider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16), // Padding kiri dan kanan
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                // Aksi yang ingin dilakukan saat widget "Kelola Kebun" di klik
                // Misalnya, tampilkan halaman kelola kebun
                showBottomSheets2(context, key: "kelola_kebun");
              },
              borderRadius:
                  BorderRadius.circular(10), // Rounded dengan radius 10
              child: Ink(
                height: 150,
                decoration: BoxDecoration(
                  color: Color(0xFF53B175), // Warna hijau
                  borderRadius:
                      BorderRadius.circular(10), // Rounded dengan radius 10
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.agriculture, // Icon kelola kebun
                      size: 50,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Kelola Kebun',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: InkWell(
              onTap: () {
                // Aksi yang ingin dilakukan saat widget "Jaringan Bisnis" di klik
                // Misalnya, tampilkan halaman jaringan bisnis
                showBottomSheets2(context, key: "kelola_kebun");
              },
              borderRadius:
                  BorderRadius.circular(10), // Rounded dengan radius 10
              child: Ink(
                height: 150,
                decoration: BoxDecoration(
                  color: Color(0xFF6096B4),
                  borderRadius:
                      BorderRadius.circular(10), // Rounded dengan radius 10
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.business, // Icon jaringan bisnis
                      size: 50,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Jaringan Bisnis',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showBottomSheets2(context,
      {String? stok, String? rincian, String? key}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          if (key == "kelola_kebun") {
            return KelolaKebunBottom("Maaf, fitur sedang dalam pengembangan.");
          }

          // } else if (key == "nutritions") {
          //   return SpesifikasiBottom(stok);
          // } else if (key == "review") {}

          return SizedBox.shrink();
        });
  }

  Widget logoutButton(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          elevation: 0,
          backgroundColor: Color(0xffF2F3F2),
          textStyle: TextStyle(
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 25),
          minimumSize: const Size.fromHeight(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              height: 20,
              child: SvgPicture.asset(
                  "assets/icons/account_icons/logout_icon.svg"),
            ),
            Text(
              "Keluar",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
        onPressed: () async {
          bool? confirmationResult = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return ConfirmationDialogLogout(
                  message: "Apakah anda yakin ingin keluar?");
            },
          );
          if (confirmationResult == true) {
            auth.logOut();
          } else {
            print("gagal");
          }
        },
      ),
    );
  }

  Widget getImageHeader(String foto) {
    return CircleAvatar(
      radius: 64.0,
      backgroundColor: AppColors.primaryColor.withOpacity(0.7),
      child: ClipOval(
        child: Image.network(
          foto,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
        ),
      ),
    );
  }

  Widget getAccountItemWidget(BuildContext context, accountItem) {
    return InkWell(
      onTap: () {
        // Aksi yang ingin dilakukan saat ikon diklik
        switch (accountItem.label) {
          case "Edit Profil":
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditProfilePage()));
            break;
          case "Edit Kebun":
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => StoreManagementPage()));
            break;
          case "Katalog":
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CatalogScreen()));
            break;
          case "Notifikasi":
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NotificationScreen()));
            break;
          case "Transaksi":
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TransactionScreen()));
            break;
          case "Status Pembelian":
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => OrderScreen()));
            break;
          case "Transaksi Petani":
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TransactionPetaniScreen()));
            break;
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: SvgPicture.asset(
                accountItem.iconPath,
              ),
            ),
            SizedBox(width: 20),
            Text(
              accountItem.label,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
