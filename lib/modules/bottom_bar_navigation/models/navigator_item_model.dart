import 'package:Apehipo/modules/hidrocommerce/screen/hidrocommerce_screen.dart';
import 'package:Apehipo/modules/vtrends/vtrends.dart';
import 'package:flutter/material.dart';
import 'package:Apehipo/modules/account/screens/account_screen.dart';
// import 'package:Apehipo/screens/cart/cart_screen.dart';

class NavigatorItem {
  final String label;
  final String iconPath;
  final int index;
  final Widget screen;

  NavigatorItem(this.label, this.iconPath, this.index, this.screen);
}

List<NavigatorItem> navigatorItems = [
  NavigatorItem(
      "HidroCommerce", "assets/icons/shop_icon.svg", 0, HidrocommerceScreen()),
  NavigatorItem("V-Trends", "assets/icons/explore_icon.svg", 1, Vtrends()),
  // NavigatorItem("Cart", "assets/icons/cart_icon.svg", 2, CartScreen()),
  // NavigatorItem(
  //     "Account", "assets/icons/favourite_icon.svg", 2, AccountScreen()),
  NavigatorItem("Account", "assets/icons/account_icon.svg", 2, AccountScreen()),
];
