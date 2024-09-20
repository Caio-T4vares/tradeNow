
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/controllers/address_controller.dart';
import 'package:trade_now/app/core/services/location_service.dart';

import '../../core/constants/color_constants.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    LocationService locationService = LocationService();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Endereços',
          style: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold, 
            fontSize: 28
          ),
        ),
        centerTitle: true,
        toolbarHeight: 80,
        backgroundColor: darkerColor
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 2)
                ),
              ],
            ),
            child: ListTile(
              title: const Text(
                'Cadastrar novo endereço',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                _showAddressModal(context, controller, locationService);
              },
            ),
          ),
          const SizedBox(height: 16,),
          Obx(() {
            if(controller.addresses.isEmpty) {
              return const Center(child: Text('Nenhum Endereço Cadastrado'),);
            } 

            return Column(
              children: controller.addresses.map((address) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      address.rua ?? '', // Exemplo de campo do endereço
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${address.cidade}, ${address.bairro}'),
                    trailing: controller.selectedAddress.value == address.id
                      ? const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 24,
                      )
                      : null,
                    onTap: () {
                      controller.setDefaultAddress(address.id!);
                    },
                  ),
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }

  void _showAddressModal(BuildContext context, AddressController controller, LocationService service) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller.stateController,
                decoration: const InputDecoration(labelText: 'Estado'),
              ),
              TextField(
                controller: controller.cityController,
                decoration: const InputDecoration(labelText: 'Cidade'),
              ),
              TextField(
                controller: controller.streetController,
                decoration: const InputDecoration(labelText: 'Rua'),
              ),
              TextField(
                controller: controller.neighborhoodController,
                decoration: const InputDecoration(labelText: 'Bairro'),
              ),
              const SizedBox(height: 16,),
              ElevatedButton(
                onPressed: () async {
                  Position position = await service.determinePosition();
                  List<Placemark> placemarks = await placemarkFromCoordinates(
                    position.latitude, position.longitude
                  );

                  if(placemarks.isNotEmpty) {
                    final place = placemarks.first;
                    controller.cityController.text = place.subAdministrativeArea ?? '';
                    controller.streetController.text = place.street ?? '';
                    controller.neighborhoodController.text = place.subLocality ?? '';
                    controller.stateController.text = place.administrativeArea ?? '';
                  }
                },
                child: const Text('Usar Localização Atual'),
              ),
              const SizedBox(height: 16,),
              ElevatedButton(
                onPressed: () {
                  controller.addAddress(
                    city: controller.cityController.text,
                    street: controller.streetController.text,
                    neighborhood: controller.neighborhoodController.text,
                    state: controller.stateController.text
                  );
                  Navigator.pop(context);
                },
                child: const Text('Salvar Endereço'),
              ),
            ],
          ),
        ),
      ),
    );
  } 
}