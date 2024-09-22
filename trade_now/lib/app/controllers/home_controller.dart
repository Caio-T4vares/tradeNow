import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/core/services/firestore_service.dart';
import 'package:trade_now/app/core/services/location_service.dart';

import '../model/address.dart';
import '../model/product.dart';

class HomeController extends GetxController {
  var currentLocationState = ''.obs;

  final LocationService _locationService = LocationService();
  final FirestoreService _firestoreService = FirestoreService();

  RxList<Product> productsList = <Product>[].obs;
  RxMap<String?, Address> productAddress = <String, Address>{}.obs;

  @override
  void onInit() async {
    super.onInit();
    _getCurrentLocationAndState();
    productsList.value = await _firestoreService.getProductsByState(currentLocationState.value);
    productAddress.value = await _firestoreService.fetchAllProductAddresses(productsList);
  }

  Future<void> _getCurrentLocationAndState() async {
    try {
      Position position = await _locationService.determinePosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      
      if (placemarks.isNotEmpty) {
        currentLocationState.value = placemarks.first.administrativeArea ?? '';
        Get.snackbar('Sucesso', 'Localização atribuída');
      } else {
        Get.snackbar('Erro', "Nenhum placemark encontrado.");
      }
    } catch (e) {
      Get.snackbar('Erro', 'Erro ao obter localização: $e');
    }
  }

  void updateLists() async {
    productsList.value = await _firestoreService.getProductsByState(currentLocationState.value);
    productAddress.value = await _firestoreService.fetchAllProductAddresses(productsList);
  }
}
