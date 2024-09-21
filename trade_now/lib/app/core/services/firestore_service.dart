import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/model/address.dart';
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

  Future<List<Product>> getProductsByState(String state) async {
    try {
      QuerySnapshot productSnapshot = await _firestore.collection('products').get();

      List<Product> products = [];
      for(var doc in productSnapshot.docs) {
        Product product = Product.fromMap(doc.data() as Map<String, dynamic>);

        Address address = await getAddressById(product.addressId);

        if(address.estado == state) {
          products.add(product);
        }
      }
      return products;
    }
    catch(e) {
      print("Error getting products by state: $e");
      return [];
    }
  }

  Future<Address> getAddressById(String? addressId) async {
    try {
      DocumentSnapshot snapshot = await _firestore.collection('addresses').doc(addressId).get();
      return Address.fromMap(snapshot.data() as Map<String, dynamic>);
    }
    catch(e) {
      print("Error getting address by ID: $e");
      throw e;
    }
  }

  Future<Map<String?, Address>> fetchAllProductAddresses(List<Product> products) async {
    Map<String?, Address> productAddress = <String, Address>{};
    for (var product in products) {
      final address = await fetchProductAddress(product.addressId);  // Chama a função async para buscar o endereço
      if (address != null) {
        productAddress[product.addressId] = address;  // Armazena o endereço no mapa
      }
    }
    return productAddress;
  }

  Future<Address?> fetchProductAddress(String? addressId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('addresses').doc(addressId).get();

      if (doc.exists) {
        return Address.fromFirestore(doc);
      } 
      else {
        print('Endereço não encontrado');
        return null;
      }
    } catch (e) {
      print('Erro ao buscar o endereço: $e');
      return null;
    }
  }
}
