import 'package:flutter/material.dart';

class AccountItem {
  final String label;
  final String iconPath;

  AccountItem(this.label, this.iconPath);
}

List<AccountItem> accountItems = [
  AccountItem("Katalog", "assets/icons/account_icons/orders_icon.svg"),
  AccountItem("Edit Profil", "assets/icons/account_icons/details_icon.svg"),
  AccountItem("Edit Toko", "assets/icons/shop.svg"),
  // AccountItem("Kelola Kebun", "assets/icons/account_icons/sprout-outline.svg"),
  AccountItem("Notifikasi", "assets/icons/account_icons/notification_icon.svg"),
  AccountItem("Status Pembelian", "../assets/icons/account_icons/copy-success-svgrepo-com.svg"),
  AccountItem("Transaksi", "../assets/icons/account_icons/delivery-truck-svgrepo-com.svg"),
  AccountItem("Bantuan", "assets/icons/account_icons/help_icon.svg"),
  AccountItem("Tentang", "assets/icons/account_icons/about_icon.svg"),
];
