import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/controllers/perfil_controller.dart';
import 'package:trade_now/app/constants/color_constants.dart';
import 'package:trade_now/app/ui/components/app_bar.dart';
import 'package:trade_now/app/ui/components/navigation_bar.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PerfilController());

    return Scaffold(
      appBar: const TopBar(nomePag: "Perfil"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Stack(
              alignment: Alignment.center, // Centraliza a imagem
              children: [
                // Imagem de perfil
                Obx(() => CircleAvatar(
                      radius: 60,
                      backgroundImage: controller.selectedImage.value != null
                          ? FileImage(controller.selectedImage.value!)
                          : const NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRurO8kRj216kjoFZVmlyf2v2eak-uUfukQKQ&s')
                              as ImageProvider,
                    )),

                // Botão de ícone de câmera
                Positioned(
                  top: 0,
                  right: -10, // Ajuste a posição para o canto superior direito
                  child: IconButton(
                    icon: Icon(Icons.camera_alt,
                        size: 30, color: Colors.grey[700]),
                    onPressed: () async {
                      await controller.selecionarImagem();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Como deseja ser chamado?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: controller.nomeController,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'CPF:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: controller.cpfController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'CPF',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Informações de Contato:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: controller.contactController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Contato',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed('/address');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: green5,
                        shadowColor: Colors.grey,
                        elevation: 5,
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 18),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Endereços',
                            style: TextStyle(
                              color: green6,
                              fontSize: 16,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed('/userAnnouncement');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: green5,
                        shadowColor: Colors.grey,
                        elevation: 5,
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 18),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Meus Anúncios',
                            style: TextStyle(
                              color: green6,
                              fontSize: 16,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.salvarDados();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: green4,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15)),
                      child: const Text(
                        'Salvar',
                        style: TextStyle(color: green6, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: green6,
      bottomNavigationBar: const NavBar(),
    );
  }
}
