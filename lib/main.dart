import 'package:apehipo_app/modules/cart/cart_change.dart';
import 'package:apehipo_app/modules/notification/notification_change.dart';
import 'package:apehipo_app/widgets/timer_provider.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartChange()),
        ChangeNotifierProvider(create: (_) => TimerProvider()),
        ChangeNotifierProvider(create: (_) => NotificationChange())
      ],
      child: MyApp(),
    ),
  );
}
