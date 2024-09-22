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

  RxList<Product> filteredList = <Product>[].obs;
  var categoria = "".obs;
  var currentLocationState = ''.obs;

  List<Product> productsList = <Product>[];
  RxMap<String?, Address> productAddress = <String, Address>{}.obs;

  @override
  void onInit() async {
    super.onInit();
    await _getCurrentLocationAndState();
    productsList = await _firestoreService.getProductsByState(currentLocationState.value);
    productAddress.value = await _firestoreService.fetchAllProductAddresses(productsList);
    filteredList.value = productsList.toList();
    filteredList.refresh();
  }

  Future<void> _getCurrentLocationAndState() async {
    try {
      Position position = await locationService.determinePosition();
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

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
      productsList = await _firestoreService.getAllProducts();
    } else {
      categoria.value = category!;
      productsList = await _firestoreService.getProductsByCategory(category);
    }
    filteredList.value = productsList.toList();
    filteredList.refresh();
  }

  void searchByName() async {
    RegExp regex = RegExp("^${searchController.text.toLowerCase()}");
    filteredList.value = productsList.where((el) {
      if (regex.hasMatch(el.name!.toLowerCase())) return true;
      return false;
    }).toList();
    filteredList.refresh();
  }

  void updateLists() async {
    productsList = await _firestoreService.getProductsByState(currentLocationState.value);
    filteredList.value = productsList.toList();
    filteredList.refresh();
    productAddress.value = await _firestoreService.fetchAllProductAddresses(filteredList);
    categoria.value = Get.arguments;
    changeCategory(categoria.value);
  }
}
