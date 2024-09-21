import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/core/constants/color_constants.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String nomePag;
  const TopBar({super.key, required this.nomePag});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.arrow_back),
      ),
      title: Text(
        nomePag,
        style: const TextStyle(
            color: lightColor, fontWeight: FontWeight.bold, fontSize: 36),
      ),
      centerTitle: true,
      toolbarHeight: 65,
      backgroundColor: darkerColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
