import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/product.dart';
import '../../model/address.dart';

class SearchProductCard extends StatelessWidget {
  final List<Product> products;
  final Map<String?, Address> productAddresses;

  const SearchProductCard({super.key, required this.products, required this.productAddresses});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        final address = productAddresses[product.addressId];

        return InkWell(
          onTap: () {
            Get.toNamed('/details', arguments: product);
          },
          child: Container(
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
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported, size: 80),
                  ),
                ),
                const SizedBox(width: 16,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name ?? 'Nome do Produto',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4,),
                      Text(
                        '${address!.cidade}, ${address.estado}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4,),
                      Text(
                        'R\$ ${product.price?.toStringAsFixed(2) ?? '0.00'}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        );
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return ListTile(
  //     shape: Border.all(color: Colors.black),
  //     onTap: () => Get.toNamed("/details", arguments: produto),
  //     leading: SizedBox(
  //       width: 80,
  //       child: Image.network(
  //         produto.imgsUrl!.first,
  //         fit: BoxFit.fill,
  //       ),
  //     ),
  //     title: SizedBox(
  //       height: 30,
  //       child: Text(
  //         "${produto.name}",
  //         style: const TextStyle(overflow: TextOverflow.ellipsis),
  //       ),
  //     ),
  //     subtitle: Text(
  //       "R\$ ${produto.price!.toStringAsFixed(2)}",
  //       style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
  //     ),
  //   );
  // }
}
