import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/model/product.dart';

class SearchProductCard extends StatelessWidget {
  final Product produto;
  const SearchProductCard({super.key, required this.produto});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: Border.all(color: Colors.black),
      onTap: () => Get.toNamed("/details"),
      leading: Image.network(
        produto.imgsUrl!.first,
        fit: BoxFit.fill,
      ),
      title: SizedBox(
        height: 30,
        child: Text(
          "${produto.name}",
          style: const TextStyle(overflow: TextOverflow.ellipsis),
        ),
      ),
      subtitle: Text(
        "R\$ ${produto.price!.toStringAsFixed(2)}",
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
