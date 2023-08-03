import 'package:apehipo_app/modules/notification/notification_screen.dart';
import 'package:apehipo_app/modules/order/order_screen.dart';
import 'package:apehipo_app/modules/transaction/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:apehipo_app/widgets/app_text.dart';
import 'package:apehipo_app/widgets/column_with_seprator.dart';
import 'package:apehipo_app/modules/account/account_edit.dart';
import 'package:apehipo_app/modules/account/account_katalog.dart';
import 'package:apehipo_app/modules/account/account_toko.dart';
import 'package:apehipo_app/widgets/colors.dart';

import 'account_item.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: SizedBox(
                  width: 65,
                  height: 65,
                  child: getImageHeader(),
                ),
                title: AppText(
                  text: "Muhammad Nazar Gunawan",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                subtitle: AppText(
                  text: "Petani Pakcoy",
                  color: Color(0xff7C7C7C),
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              getHorizontalItemSlider(), // Tambahkan widget getHorizontalItemSlider() di sini
              Column(
                children: getChildrenWithSeperator(
                  widgets: accountItems.map((e) {
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
              logoutButton(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
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

  Widget logoutButton() {
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
            Container()
          ],
        ),
        onPressed: () {},
      ),
    );
  }

  Widget getImageHeader() {
    String imagePath = "assets/images/account_image.jpg";
    return CircleAvatar(
      radius: 5.0,
      backgroundImage: AssetImage(imagePath),
      backgroundColor: AppColors.primaryColor.withOpacity(0.7),
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
          case "Edit Toko":
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => StoreManagementPage()));
            break;
          case "Katalog":
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ManageProductsPage()));
            break;
          case "Notifikasi":
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NotificationScreen()));
            break;
          // case "Transaksi":
          //   Navigator.push(context,
          //       MaterialPageRoute(builder: (context) => TransactionScreen()));
          //   break;
          // case "Status Pembelian":
          //   Navigator.push(context,
          //       MaterialPageRoute(builder: (context) => OrderScreen()));
          //   break;
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
