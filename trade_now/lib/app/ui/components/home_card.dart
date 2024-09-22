import 'package:flutter/material.dart';
import 'package:trade_now/app/model/address.dart';
import 'package:trade_now/app/model/product.dart';

class HomeCard extends StatelessWidget {
  final String category;
  final List<Product> products;
  final Map<String?, Address> productAddress;

  const HomeCard(
      {super.key,
      required this.category,
      required this.products,
      required this.productAddress});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final address = productAddress[product.addressId];

              return Container(
                width: 150,
                margin: const EdgeInsets.only(right: 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Alinhamento à esquerda
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          product.imgsUrl!.isNotEmpty ? product.imgsUrl![0] : '',
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported, size: 100),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Alinhamento à esquerda
                          children: [
                            Text(
                              (product.name != null && product.name!.length > 20)
                                  ? '${product.name!.substring(0, 20)}...'
                                  : product.name ?? 'Nome do Produto',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'R\$ ${product.price?.toStringAsFixed(2) ?? '0.00'}',
                              style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
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
