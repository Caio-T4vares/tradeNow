import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/core/services/firestore_service.dart';
import 'package:trade_now/app/core/services/location_service.dart';

import '../model/address.dart';
import '../model/product.dart';

class SearchPageController extends GetxController {
  TextEditingController searchController = TextEditingController();

  final LocationService locationService = LocationService();
  final FirestoreService _firestoreService = Get.find();

  var productList = [];
  var filteredList = [].obs;
  var categoria = "".obs;
  var currentLocationState = ''.obs;

  RxList<Product> productsList = <Product>[].obs;
  RxMap<String?, Address> productAddress = <String, Address>{}.obs;

  @override
  void onInit() async {
    super.onInit();
    await _getCurrentLocationAndState();
    productsList.value = await _firestoreService.getProductsByState(currentLocationState.value);
    productAddress.value = await _firestoreService.fetchAllProductAddresses(productsList);
  }

  Future<void> _getCurrentLocationAndState() async {
    try {
      Position position = await locationService.determinePosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      
      if (placemarks.isNotEmpty) {
        currentLocationState.value = placemarks.first.administrativeArea ?? '';
      } else {
        Get.snackbar('Erro', "Nenhum placemark encontrado.");
      }
    } catch (e) {
      Get.snackbar('Erro', 'Erro ao obter localização: $e');
    }
  }
  
  void changeCategory(String? category) async {
    if (category == "") {
      categoria.value = "";
      productList = await _firestoreService.getAllProducts();
    } else {
      categoria.value = category!;
      productList = await _firestoreService.getProductsByCategory(category);
    }
    filteredList.value = productList.toList();
    filteredList.refresh();
  }

  void searchByName() async {
    RegExp regex = RegExp("^${searchController.text.toLowerCase()}");
    filteredList.value = productList.where((el) {
      if (regex.hasMatch(el.name.toLowerCase())) return true;
      return false;
    }).toList();
    filteredList.refresh();
  }
}
