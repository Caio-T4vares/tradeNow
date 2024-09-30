import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/constants/color_constants.dart';
import 'package:trade_now/app/model/product.dart';

import '../../controllers/product_details_controller.dart';

class HomeCard extends StatelessWidget {
  final String category;
  final List<Product> products;
  final int comingFrom;

  const HomeCard({
    super.key,
    required this.category,
    required this.products,
    required this.comingFrom,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        comingFrom == 0
            ? Row(
              children: [
                Text(
                  category,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10,),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/search', arguments: category);
                  },
                  child: const Text(
                    "Ver mais...",
                    style: TextStyle(
                      fontSize: 16,
                      color: green5
                    ),
                  ),
                ),
              ],
            )
            : const SizedBox(
                height: 0,
              ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: products.isEmpty
              ? Center(
                  child: Text(
                    'Sem produtos na sua área',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length > 10 ? 10 : products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];

                    return InkWell(
                      onTap: () {
                        switch (comingFrom) {
                          case 0:
                            Get.toNamed('/details', arguments: product);
                            break;
                          case 1:
                            Get.delete<ProductDetailsController>();
                            Get.offAndToNamed("/details", arguments: product);
                            break;
                        }
                      }, // Função de clique
                      child: Container(
                        width: 150,
                        margin: const EdgeInsets.only(right: 10),
                        child: Card(
                          color: green5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Alinhamento à esquerda
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  product.imgsUrl!.isNotEmpty
                                      ? product.imgsUrl![0]
                                      : '',
                                  height: 100,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                    Icons.image_not_supported,
                                    size: 100,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start, // Alinhamento à esquerda
                                  children: [
                                    Text(
                                      (product.name != null &&
                                              product.name!.length > 20)
                                          ? '${product.name!.substring(0, 20)}...'
                                          : product.name ?? 'Nome do Produto',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: green4),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'R\$ ${product.price?.toStringAsFixed(2) ?? '0.00'}',
                                      style: const TextStyle(
                                        color: green6,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
