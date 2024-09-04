import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:trade_now/app/routes/app_pages.dart';

void main() {
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
      initialRoute: Routes.login,
      getPages: AppPages().pages,
    );
  }
}
