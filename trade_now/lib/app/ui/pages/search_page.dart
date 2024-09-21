import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/controllers/search_controller.dart';
import 'package:trade_now/app/core/constants/color_constants.dart';
import 'package:trade_now/app/model/product.dart';
import 'package:trade_now/app/ui/components/app_bar.dart';
import 'package:trade_now/app/ui/components/navigation_bar.dart';
import 'package:trade_now/app/ui/components/search_product_card.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});
  @override
  Widget build(BuildContext context) {
    var screenWidth = Get.mediaQuery.size.width;
    var screenHeight = Get.mediaQuery.size.height;
    List<String> categorias = ["", "Eletrônicos", "Móveis", "Livros"];
    final controller = Get.put(SearchPageController());
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
            TextButton(
                onPressed: () {/*pra abrir popup*/},
                child: Container(
                    width: 160,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    child: const Row(children: [
                      Icon(Icons.place),
                      Text(
                        "Sua localização",
                        overflow: TextOverflow.ellipsis,
                      )
                    ]))),
            const SizedBox(
              height: 15,
            ),
            Obx(
              () => Text(controller.categoria.value == ""
                  ? ""
                  : "Encontrados em ${controller.categoria.value}"),
            ),
            const SizedBox(
              height: 15,
            ),
            Obx(() => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.filteredList.length > 10
                          ? 10
                          : controller.filteredList.length,
                      itemBuilder: (BuildContext build, int index) {
                        return Column(
                          children: [
                            SearchProductCard(
                                produto: controller.filteredList.value[index]),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ))
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
