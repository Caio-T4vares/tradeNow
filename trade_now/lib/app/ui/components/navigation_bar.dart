import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/controllers/navigation_bar_controller.dart';
import 'package:trade_now/app/core/constants/color_constants.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationBarController());

    return Obx(() => NavigationBar(
      selectedIndex: controller.selectedIndex.value,
      onDestinationSelected: controller.onItemTapped,
      backgroundColor: darkerColor,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        NavigationDestination(
          icon: Icon(Icons.add_circle),
          label: 'Annoucement',
        ),
        NavigationDestination(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
    ));
  }
}
