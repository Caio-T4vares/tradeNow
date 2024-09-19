import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/core/services/firestore_service.dart';
import 'package:trade_now/app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(FirestoreService());
  runApp(const TradeNowApp());
}

class TradeNowApp extends StatelessWidget {
  const TradeNowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      title: "Trade Now",
      initialRoute: Routes.details,
      getPages: AppPages().pages,
    );
  }
}
