import 'package:flutter/material.dart';

class CartChange with ChangeNotifier {
  int itemCount = 0;
  void incrementCounter(int count) {
    // Ini adalah bagian di mana Anda melakukan perubahan pada variabel state
    itemCount = count;
    notifyListeners();
  }

  void resetValue() {
    itemCount = 0;
    notifyListeners();
  }
}
