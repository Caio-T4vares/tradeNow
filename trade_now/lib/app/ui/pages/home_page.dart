import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/controllers/home_controller.dart';
import 'package:trade_now/app/constants/color_constants.dart';
import 'package:trade_now/app/ui/components/app_bar.dart';
import 'package:trade_now/app/ui/components/category_card.dart';
import 'package:trade_now/app/ui/components/home_card.dart';
import 'package:trade_now/app/ui/components/navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    controller.updateLists();
    return Scaffold(
      appBar: const TopBar(nomePag: "Home"),
      body: SingleChildScrollView(
        // Adicionando o SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Carrossel de produtos
              Obx(() {
                if (controller.productsList.isEmpty ||
                    controller.productAddress.isEmpty) {
                  controller.updateLists();
                  return const Text('Carregando Itens...');
                }

                final filteredProducts = controller.productsList
                    .where((product) => product.category == 'Eletrônicos')
                    .toList();

                return HomeCard(
                  category: 'Eletrônicos',
                  products: filteredProducts,
                  comingFrom: 0,
                );
              }),
              const SizedBox(height: 10),
              Obx(() {
                if (controller.productsList.isEmpty ||
                    controller.productAddress.isEmpty) {
                  controller.updateLists();
                  return const Text('Carregando Itens...');
                }

                final filteredProducts = controller.productsList
                    .where((product) => product.category == 'Móveis')
                    .toList();

                return HomeCard(
                  category: 'Móveis',
                  products: filteredProducts,
                  comingFrom: 0,
                );
              }),
              const SizedBox(height: 10),
              Obx(() {
                if (controller.productsList.isEmpty ||
                    controller.productAddress.isEmpty) {
                  controller.updateLists();
                  return const Text('Carregando Itens...');
                }

                final filteredProducts = controller.productsList
                    .where((product) => product.category == 'Livros')
                    .toList();

                return HomeCard(
                  category: 'Livros',
                  products: filteredProducts,
                  comingFrom: 0,
                );
              }),
              const SizedBox(height: 10),
              Obx(() {
                if (controller.productsList.isEmpty ||
                    controller.productAddress.isEmpty) {
                  controller.updateLists();
                  return const Text('Carregando Itens...');
                }

                final filteredProducts = controller.productsList
                    .where((product) => product.category == 'Automóveis')
                    .toList();

                return HomeCard(
                  category: 'Automóveis',
                  products: filteredProducts,
                  comingFrom: 0,
                );
              }),
            ],
          ),
        ),
      ),
      backgroundColor: green6,
      bottomNavigationBar: const NavBar(),
    );
  }
}
