import 'package:Apehipo/modules/cart/cart_change.dart';
import 'package:Apehipo/modules/notification/notification_change.dart';
import 'package:Apehipo/widgets/timer_provider.dart';
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
