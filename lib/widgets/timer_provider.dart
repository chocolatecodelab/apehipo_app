import 'dart:async';
import 'package:Apehipo/modules/order/order_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class TimerProvider extends ChangeNotifier {
  late Timer _timer;
  int _remainingTime = 3600;
  String? idOrder;
  final controller = Get.put(OrderController());

  TimerProvider() {
    startTimer();
  }

  String formatTime() {
    int hours = _remainingTime ~/ 3600;
    int minutes = (_remainingTime % 3600) ~/ 60;
    int seconds = _remainingTime % 60;

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  }

  void startTimer() {
    const oneSecond = const Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      if (_remainingTime > 0) {
        _remainingTime -= 1;
        notifyListeners(); // Memberitahu listener (widget) untuk merender ulang
      } else {
        controller.deleteData(idOrder);
        timer.cancel(); // Hentikan timer
      }
    });
  }

  void resetTimer() {
    _remainingTime = 3600;
    notifyListeners(); // Memberitahu listener (widget) untuk merender ulang
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
