import 'package:get/get.dart';
import 'package:trade_now/app/core/services/firestore_service.dart';
import 'package:trade_now/app/model/product.dart';

class ProductDetailsController extends GetxController {
  final FirestoreService _firestoreService = Get.find();
  var product = Product(imgsUrl: []).obs;
  var productsSameCategory = [].obs;
  var currentPage = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    product.value = List.from(await _firestoreService.getAllProducts()).first;
    productsSameCategory.value = List.from(
        await _firestoreService.getProductsByCategory(product.value.category!));
    product.refresh();
    productsSameCategory.refresh();
  }
}
