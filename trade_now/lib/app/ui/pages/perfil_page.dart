import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/controllers/perfil_controller.dart';
import 'package:trade_now/app/core/constants/color_constants.dart';
import 'package:trade_now/app/ui/components/navigation_bar.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = Get.mediaQuery.size.width;
    var screenHeight = Get.mediaQuery.size.height;
    final controller = Get.put(PerfilController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Perfil",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 36),
        ),
        centerTitle: true,
        toolbarHeight: 80,
        backgroundColor: darkerColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Stack(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRurO8kRj216kjoFZVmlyf2v2eak-uUfukQKQ&s'),
                    backgroundColor: Colors.grey[200],
                  ),
                ),
                Positioned(
                  top: 10,
                  right: screenWidth * 0.25,
                  child: GestureDetector(
                    onTap: () {
                      //TODO TROCAR IMAGEM
                    },
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.camera_alt, color: Colors.black, size: 20,),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Como deseja ser chamado?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: controller.nomeController,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'CPF:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: controller.cpfController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'CPF',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        //TODO Salvar Mudanças
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttomColor,
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15)
                      ),
                      child: Text('Salvar', style: TextStyle(color: Colors.black, fontSize: 18),),
                    ),
                  ),
                  SizedBox(height: 30,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        //TODO Levar para tela de endereços
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shadowColor: Colors.grey,
                        elevation: 5,
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Endereços',
                            style: TextStyle(
                              color: Colors.black,
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
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}
