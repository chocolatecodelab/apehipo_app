import 'package:Apehipo/auth/auth_controller.dart';
import 'package:Apehipo/auth/login/login.dart';
import 'package:Apehipo/modules/account/account_controller.dart';
import 'package:Apehipo/modules/cart/cart_change.dart';
import 'package:Apehipo/modules/notification/notification_screen.dart';
import 'package:Apehipo/modules/order/order_screen.dart';
import 'package:Apehipo/modules/transaction/transaction_screen.dart';
import 'package:Apehipo/modules/transaction/transcation_screen_petani.dart';
import 'package:Apehipo/widgets/confirmation_dialog_logout.dart';
import 'package:Apehipo/widgets/success_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Apehipo/widgets/app_text.dart';
import 'package:Apehipo/widgets/column_with_seprator.dart';
import 'package:Apehipo/modules/account/account_edit.dart';
import 'package:Apehipo/modules/catalog/katalog_screen.dart';
import 'package:Apehipo/modules/account/account_toko.dart';
import 'package:Apehipo/widgets/colors.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

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
    controller.refresh();
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
                if (auth.box.read("role") != "admin")
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
                                text: auth.box.read("nama"),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              subtitle: AppText(
                                text: auth.box.read("role"),
                                color: Color(0xff7C7C7C),
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                              ),
                            )),
                SizedBox(
                  height: 15,
                ),
                // getHorizontalItemSlider(), // Tambahkan widget getHorizontalItemSlider() di sini
                Column(
                  children: getChildrenWithSeperator(
                    widgets: accountItems
                        .where((item) => shouldDisplay(
                            item)) // Ganti shouldDisplay dengan kondisi yang sesuai
                        .map((e) {
                      return getAccountItemWidget(context, e);
                    }).toList(),
                    seperator: Divider(
                      thickness: 1,
                    ),
                  ),
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
      if (item.label == "Transaksi" ||
          item.label == "Status Pembelian" ||
          item.label == "Edit Kebun") {
        return false;
      }
      return true;
    } else if (auth.box.read("role") == "konsumen") {
      if (item.label == "Transaksi Petani" ||
          item.label == "Edit Kebun" ||
          item.label == "Katalog" ||
          item.label == "Transaksi") {
        return false;
      }
      return true;
    } else {
      if (item.label == "Transaksi Petani" ||
          item.label == "Edit Kebun" ||
          item.label == "Katalog" ||
          item.label == "Transaksi" ||
          item.label == "Edit Profil" ||
          item.label == "Notifikasi" ||
          item.label == "Bantuan" ||
          item.label == "Tentang") {
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
                print('Kelola Kebun diklik');
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
                print('Jaringan Bisnis diklik');
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: SvgPicture.asset(
                "assets/icons/account_icons/logout_icon.svg",
              ),
            ),
            Text(
              "Keluar",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor),
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
          if (confirmationResult!) {
            String? hasil = await auth.logOut();
            if (hasil == "sukses") {
              SuccessConfirmationDialog(
                  message: "Anda telah keluar dari akun",
                  icon: Icons.check_circle_outline);
              Get.offAll(LoginPage());
            }
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
          case "Status Pembelian":
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => OrderScreen()));
            break;
          case "Transaksi Petani":
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TransactionScreen()));
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

  @override
  void dispose() {
    super.dispose();
  }
}
