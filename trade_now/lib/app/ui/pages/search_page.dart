import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/controllers/search_controller.dart';
import 'package:trade_now/app/core/constants/color_constants.dart';
import 'package:trade_now/app/ui/components/app_bar.dart';
import 'package:trade_now/app/ui/components/navigation_bar.dart';
import 'package:trade_now/app/ui/components/search_product_card.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});
  @override
  Widget build(BuildContext context) {
    var screenWidth = Get.mediaQuery.size.width;
    var screenHeight = Get.mediaQuery.size.height;
    List<String> categorias = [
      "",
      "Automóveis",
      "Eletrônicos",
      "Móveis",
      "Livros"
    ];
    final controller = Get.put(SearchPageController());
    controller.updateLists();

    return Scaffold(
      appBar: const TopBar(nomePag: "Buscar"),
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: screenWidth * 0.60,
                    height: 40,
                    child: TextField(
                      controller: controller.searchController,
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (value) => controller.searchByName(),
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 5),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)))),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Obx(() => SizedBox(
                        width: screenWidth * 0.3,
                        child: DropdownButton(
                          isDense: true,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                          hint: const Text(
                            "Categoria",
                            overflow: TextOverflow.ellipsis,
                          ),
                          isExpanded: true,
                          items: categorias
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                overflow: TextOverflow.ellipsis,
                              ), // Texto exibido na lista
                            );
                          }).toList(),
                          onChanged: (item) => controller.changeCategory(item),
                          value: controller.categoria.value.isEmpty
                              ? null
                              : controller.categoria.value,
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Obx(() {
              return Text(controller.currentLocationState.value.isNotEmpty
                  ? 'Exibindo resultados em ${controller.currentLocationState.value}'
                  : 'Localizando...',
                  style: const TextStyle(color: green4),
              );
            }),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Obx(() {
                if (controller.filteredList.isEmpty ||
                    controller.productAddress.isEmpty) {
                  return const Center(
                    child: Text('Nenhum anúncio encontrado', style: TextStyle(color: green3),),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: SearchProductCard(
                      products: controller.filteredList,
                      productAddresses: controller.productAddress),
                );
              }),
            ),
          ],
        ),
      ),
      backgroundColor: green6,
      bottomNavigationBar: const NavBar(),
    );
  }
}
