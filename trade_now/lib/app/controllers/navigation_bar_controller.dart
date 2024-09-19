
import 'package:get/get.dart';

class NavigationBarController extends GetxController {
  var selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;

    switch(index) {
      case 0: Get.toNamed('/home'); break;
      case 1: Get.toNamed('/search'); break;
      case 2: Get.toNamed('/announcement'); break;
      case 3: Get.toNamed('/perfil'); break;
    }
  }
}