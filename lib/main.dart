import 'package:Apehipo/modules/cart/cart_change.dart';
import 'package:Apehipo/modules/notification/notification_change.dart';
import 'package:Apehipo/modules/notification/notification_handle_notification.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'package:provider/provider.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await NotificationHandlerController.initializeLocalNotifications();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartChange()),
        ChangeNotifierProvider(create: (_) => NotificationChange())
      ],
      child: MyApp(),
    ),
  );
}
