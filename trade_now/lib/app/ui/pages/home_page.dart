import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/controllers/home_controller.dart';
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
      body: SingleChildScrollView( // Adicionando o SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Cards de categoria
              GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                childAspectRatio: 1.5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // Para evitar rolagem no GridView
                children: [
                  CategoryCard(
                    icon: Icons.phone_android,
                    label: 'Eletrônicos',
                    onTap: () {
                      // TODO Levar para tela de pesquisa
                    },
                  ),
                  CategoryCard(
                    icon: Icons.chair,
                    label: 'Móveis',
                    onTap: () {
                      // TODO Levar para tela de pesquisa
                    },
                  ),
                  CategoryCard(
                    icon: Icons.directions_car,
                    label: 'Automóveis',
                    onTap: () {
                      // TODO Levar para tela de pesquisa
                    },
                  ),
                  CategoryCard(
                    icon: Icons.book,
                    label: 'Livros',
                    onTap: () {
                      // TODO Levar para tela de pesquisa
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Carrossel de produtos
              Obx(() {
                if (controller.productsList.isEmpty || controller.productAddress.isEmpty) {
                  controller.updateLists();
                  return const Text('Carregando Itens...');
                }

                final filteredProducts = controller.productsList
                  .where((product) => product.category == 'Eletrônicos')
                  .toList();

                return HomeCard(
                  category: 'Eletrônicos',
                  products: filteredProducts,
                  productAddress: controller.productAddress,
                );
              }),
              const SizedBox(height: 10),
              Obx(() {
                if (controller.productsList.isEmpty || controller.productAddress.isEmpty) {
                  controller.updateLists();
                  return const Text('Carregando Itens...');
                }

                final filteredProducts = controller.productsList
                  .where((product) => product.category == 'Móveis')
                  .toList();

                return HomeCard(
                  category: 'Móveis',
                  products: filteredProducts,
                  productAddress: controller.productAddress,
                );
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}
