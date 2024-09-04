import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/controllers/home_controller.dart';
import 'package:trade_now/app/core/constants/color_constants.dart';
import 'package:trade_now/app/ui/components/navigation_bar.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SearchBar(
          hintText: "Busque seu produto",
        ),
        actions: const [Icon(Icons.notifications)],
        backgroundColor: darkerColor,
      ),
      body: const Placeholder(),
      bottomNavigationBar: const NavBar(),
      backgroundColor: bgColor,
    );
  }
}
