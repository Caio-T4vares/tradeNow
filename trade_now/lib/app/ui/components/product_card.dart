import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  final List<String> imgsUrl;
  final String name;
  final double price;
  const ProductCard(
      {super.key,
      required this.imgsUrl,
      required this.name,
      required this.price});

  @override
  Widget build(BuildContext context) {
    var screenWidth = Get.mediaQuery.size.width;
    var screenHeight = Get.mediaQuery.size.height;
    return Card(
      child: Column(
        children: [
          SizedBox(
            height: 80,
            width: screenWidth * 0.3,
            child: Image.network(
              fit: BoxFit.fill,
              imgsUrl.first,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: screenWidth * 0.3,
            child: Text(
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              name,
              style:
                  const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
          ),
          Text("R\$ ${price.toStringAsFixed(2)}"),
        ],
      ),
    );
  }
}
