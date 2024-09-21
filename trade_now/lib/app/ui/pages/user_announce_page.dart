import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/controllers/announcement_controller.dart';
import 'package:trade_now/app/ui/components/search_product_card.dart';

import '../../core/constants/color_constants.dart';

class UserAnnouncePage extends StatelessWidget {
  const UserAnnouncePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AnnouncementController());
    controller.getUserProducts();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Meus Anúncios",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
        ),
        centerTitle: true,
        toolbarHeight: 80,
        backgroundColor: darkerColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          if(controller.userProducts.isEmpty || controller.productAddress.isEmpty) {
            return const Center(child: Text('Nenhum anúncio encontrado'),);
          }

          return SearchProductCard(
            products: controller.userProducts, 
            productAddresses: controller.productAddress
          );
        }),
      ),
    );
  }
}