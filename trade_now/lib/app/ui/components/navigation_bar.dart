import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/controllers/navigation_bar_controller.dart';
import 'package:trade_now/app/core/constants/color_constants.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationBarController());

    return Obx(() => NavigationBarTheme(
          data: NavigationBarThemeData(
            labelTextStyle: WidgetStateProperty.all(
              const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          child: NavigationBar(
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: controller.onItemTapped,
            backgroundColor: green4,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home, color: green5),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.search, color: green5),
                label: 'Search',
              ),
              NavigationDestination(
                icon: Icon(Icons.add_circle, color: green5),
                label: 'Annoucement',
              ),
              NavigationDestination(
                icon: Icon(Icons.person, color: green5),
                label: 'Perfil',
              ),
            ],
          ),
        ));
  }
}
