import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/controllers/announcement_controller.dart';
import 'package:trade_now/app/model/address.dart';
import 'package:trade_now/app/ui/components/app_bar.dart';

import '../../constants/color_constants.dart';

class AnnouncementPage extends StatelessWidget {
  const AnnouncementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AnnouncementController());

    return Scaffold(
      appBar: const TopBar(nomePag: "Anunciar"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () async {
                  await controller
                      .selecionarImagens(); // Função para selecionar imagens
                },
                child: Obx(() {
                  return Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: controller.selectedImages.isEmpty
                        ? const Center(
                            child: Text(
                              'Clique para adicionar até 3 imagens',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                            ),
                          )
                        : CarouselSlider(
                            options: CarouselOptions(
                              height: 300,
                              enableInfiniteScroll: false,
                              enlargeCenterPage: true,
                            ),
                            items: controller.selectedImages.map((imageFile) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    imageFile,
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                  );
                }),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.titleController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.descriptionController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Row para Preço e Categoria lado a lado
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: controller.priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Preço',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: Obx(() {
                      return DropdownButtonFormField<String>(
                        value: controller.selectedCategory.value,
                        decoration: const InputDecoration(
                          labelText: 'Categoria',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          controller.selectedCategory.value = value!;
                        },
                        items: [
                          'Eletrônicos',
                          'Móveis',
                          'Livros',
                          'Automóveis',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Row para Condição e Endereço lado a lado
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Obx(() {
                      return DropdownButtonFormField<String>(
                        value: controller.selectedCondition.value,
                        decoration: const InputDecoration(
                          labelText: 'Condição',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          controller.selectedCondition.value = value!;
                        },
                        items: ['Novo', 'Usado']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      );
                    }),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: Obx(() {
                      return DropdownButtonFormField<Address>(
                        value: controller.selectedAddress.value,
                        decoration: const InputDecoration(
                          labelText: 'Endereço',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          controller.selectedAddress.value = value!;
                        },
                        selectedItemBuilder: (BuildContext context) {
                          return controller.addresses.map((Address address) {
                            String? displayText = address.rua!.length > 13
                                ? '${address.rua?.substring(0, 13)}...'
                                : address.rua;
                            return Text(displayText!);
                          }).toList();
                        },
                        items: controller.addresses.map((Address address) {
                          return DropdownMenuItem(
                            value: address,
                            child: Text('${address.rua}'),
                          );
                        }).toList(),
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    controller.salvarAnuncio();
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: green4,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                  ),
                  child: const Text(
                    'Publicar Anúncio',
                    style: TextStyle(color: green6, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: green6,
    );
  }
}
