import 'package:flutter/material.dart';
import 'package:apehipo_app/modules/account/account_screen.dart';
// import 'package:apehipo_app/screens/cart/cart_screen.dart';
import 'package:apehipo_app/screens/explore_screen.dart';
import 'package:apehipo_app/modules/home/home_screen.dart';

// import '../favourite_screen.dart';

class NavigatorItem {
  final String label;
  final String iconPath;
  final int index;
  final Widget screen;

  NavigatorItem(this.label, this.iconPath, this.index, this.screen);
}

List<NavigatorItem> navigatorItems = [
  NavigatorItem("HidroCommerce", "assets/icons/shop_icon.svg", 0, HomeScreen()),
  NavigatorItem(
      "V-Trends", "assets/icons/explore_icon.svg", 1, ExploreScreen()),
  // NavigatorItem("Cart", "assets/icons/cart_icon.svg", 2, CartScreen()),
  // NavigatorItem(
  //     "Favourite", "assets/icons/favourite_icon.svg", 3, FavouriteScreen()),
  NavigatorItem("Account", "assets/icons/account_icon.svg", 2, AccountScreen()),
];
