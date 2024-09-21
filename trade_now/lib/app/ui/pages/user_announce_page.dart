import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/controllers/announcement_controller.dart';

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
          if(controller.userProducts.isEmpty) {
            return const Center(child: Text('Nenhum anúncio encontrado'),);
          }

          return ListView.builder(
            itemCount: controller.userProducts.length,
            itemBuilder: (context, index) {
              final product = controller.userProducts[index];

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        product.imgsUrl!.isNotEmpty ? product.imgsUrl![0] : '',
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context,error,stackTrace) => const Icon(Icons.image_not_supported, size: 80),
                      ),
                    ),
                    const SizedBox(width: 16,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name ?? 'Nome do Produto',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4,),
                          Text(
                            'R\$ ${product.price?.toStringAsFixed(2) ?? '0.00'}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}