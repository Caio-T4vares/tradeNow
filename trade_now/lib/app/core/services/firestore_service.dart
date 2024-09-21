import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/model/product.dart';

class FirestoreService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Exemplo de método para adicionar dados
  Future<void> add(String collection, Map<String, dynamic> data) {
    return _firestore.collection(collection).add(data);
  }

  Future<List<Product>> getAllProducts() async {
    List<Product> allProducts = [];

    QuerySnapshot querySnapshot = await _firestore.collection("products").get();

    for (DocumentSnapshot item in querySnapshot.docs) {
      Map<String, dynamic>? map = item.data() as Map<String, dynamic>?;
      Product product = Product.fromJson(map!);
      product.id = item.id;
      allProducts.add(product);
    }
    return allProducts;
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    List<Product> allProducts = [];

    QuerySnapshot querySnapshot = await _firestore
        .collection("products")
        .where("category", isEqualTo: category)
        .get();

    for (DocumentSnapshot item in querySnapshot.docs) {
      Map<String, dynamic>? map = item.data() as Map<String, dynamic>?;
      Product product = Product.fromJson(map!);
      product.id = item.id;
      allProducts.add(product);
    }
    return allProducts;
  }
}
