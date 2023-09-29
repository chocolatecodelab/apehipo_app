import 'package:apehipo_app/modules/notification/notification_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class NotificationChange with ChangeNotifier {
  int itemCount = 0;
  var notificationController = Get.put(NotificationController());

  void incrementCounter(int count) {
    itemCount = count;
    notifyListeners();
  }

  void resetValue(int count) {
    itemCount = count;
    notifyListeners();
  }
}
