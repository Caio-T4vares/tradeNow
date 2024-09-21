import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/controllers/home_controller.dart';
import 'package:trade_now/app/core/constants/color_constants.dart';
import 'package:trade_now/app/ui/components/app_bar.dart';
import 'package:trade_now/app/ui/components/navigation_bar.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TopBar(nomePag: "Home"),
      body: Placeholder(),
      bottomNavigationBar: NavBar(),
      backgroundColor: bgColor,
    );
  }
}
