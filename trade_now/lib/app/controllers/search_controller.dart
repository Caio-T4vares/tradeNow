import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/core/services/firestore_service.dart';

class SearchPageController extends GetxController {
  final FirestoreService _firestoreService = Get.find();
  TextEditingController searchController = TextEditingController();
  var filteredList = [].obs;
  var categoria = "".obs;
  var productList = [];
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    productList = await _firestoreService.getAllProducts();
    filteredList.value = productList.toList();
    filteredList.refresh();
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
