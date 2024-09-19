import 'package:get/get.dart';
import 'package:trade_now/app/core/services/firestore_service.dart';
import 'package:trade_now/app/model/product.dart';

class ProductDetailsController extends GetxController {
  final FirestoreService _firestoreService = Get.find();
  var product = Product(imgsUrl: []).obs;

  @override
  void onInit() async {
    product.value = List.from(await _firestoreService.getAllProducts()).first;
    product.refresh();
  }
}
