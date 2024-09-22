import 'package:get/get.dart';
import 'package:trade_now/app/core/services/firestore_service.dart';
import 'package:trade_now/app/model/address.dart';
import 'package:trade_now/app/model/product.dart';

class ProductDetailsController extends GetxController {
  final FirestoreService _firestoreService = Get.find();
  var product = Product(imgsUrl: []).obs;
  RxList<Product> productsSameCategory = <Product>[].obs;
  var currentPage = 0.obs;
  var contactLink = "";
  var adressStr = "";
  @override
  void onInit() async {
    super.onInit();
    product.value = Get.arguments;
    productsSameCategory.value = List.from(
        await _firestoreService.getProductsByCategory(product.value.category!));
    productsSameCategory.removeWhere((el) => el.name == product.value.name);
    contactLink = await _firestoreService.getContactById(product.value.userId!);
    Address adress =
        await _firestoreService.getAddressById(product.value.addressId);
    adressStr = "${adress.cidade}, ${adress.estado}";
    contactLink = "https://wa.me/55$contactLink";
    product.refresh();
    productsSameCategory.refresh();
  }
}
