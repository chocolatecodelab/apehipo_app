import 'modules/cart/screen/cart_change.dart';
import 'modules/notification/notification_change.dart';
import 'services/firebase_api.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await NotificationHandlerController.initializeLocalNotifications();

  // firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseApi().initNotifications();

  // await initializeDateFormatting('id_ID', null);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartChange()),
        ChangeNotifierProvider(create: (_) => NotificationChange()),
      ],
      child: MyApp(),
    ),
  );
}
