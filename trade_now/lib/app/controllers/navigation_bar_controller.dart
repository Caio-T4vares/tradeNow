import 'package:get/get.dart';
import 'package:trade_now/app/core/services/firestore_service.dart';

class NavigationBarController extends GetxController {
  var selectedIndex = 0.obs;

  final FirestoreService _service = FirestoreService();

  Future<void> onItemTapped(int index) async {
    selectedIndex.value = index;

    switch(index) {
      case 0: Get.toNamed('/home'); break;
      case 1: Get.toNamed('/search', arguments: 'Todos'); break;
      case 2: await _service.isUserDataOk() ? Get.toNamed('/announcement') : Get.snackbar('Falta de Informações:', 'Preencha seus Dados no Perfil'); break;
      case 3: Get.toNamed('/perfil'); break;
    }
  }
}