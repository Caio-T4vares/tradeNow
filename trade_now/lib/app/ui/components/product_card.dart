import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imgUrl;
  final String name;
  final double price;
  const ProductCard(
      {super.key,
      required this.imgUrl,
      required this.name,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(
              fit: BoxFit.fill,
              "https://static.wikia.nocookie.net/bleach/images/e/e4/Ichigo_Kurosaki_TYBW.png/revision/latest?cb=20231002190352&path-prefix=pt"),
          const SizedBox(
            height: 5,
          ),
          Text(
            name,
            style: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
          ),
          Text("R\$ ${price.toStringAsFixed(2)}"),
        ],
      ),
    );
  }
}
