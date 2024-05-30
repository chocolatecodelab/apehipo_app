import 'package:Apehipo/modules/notification/controller/notification_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class NotificationChange with ChangeNotifier {
  int itemCount = 0;
  var notificationController = Get.put(NotificationController());

  void incrementCounter(int count) {
    itemCount = count;
    notifyListeners();
  }

  void resetValue() {
    itemCount = 0;
    notifyListeners();
  }
}
