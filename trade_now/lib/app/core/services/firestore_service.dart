import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/model/address.dart';
import 'package:trade_now/app/model/product.dart';

class FirestoreService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Exemplo de método para adicionar dados
  Future<void> add(String collection, Map<String, dynamic> data) {
    return _firestore.collection(collection).add(data);
  }

  Future<List<Product>> getAllProducts() async {
    List<Product> allProducts = [];

    QuerySnapshot querySnapshot = await _firestore.collection("products").get();

    for (DocumentSnapshot item in querySnapshot.docs) {
      Map<String, dynamic>? map = item.data() as Map<String, dynamic>?;
      Product product = Product.fromMap(map!);
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
      Product product = Product.fromMap(map!);
      product.id = item.id;
      allProducts.add(product);
    }
    return allProducts;
  }

  Future<List<Product>> getProductsByState(String state) async {
    try {
      QuerySnapshot productSnapshot =
          await _firestore.collection('products').get();

      List<Product> products = [];
      for (var doc in productSnapshot.docs) {
        Product product = Product.fromMap(doc.data() as Map<String, dynamic>);

        Address address = await getAddressById(product.addressId);

        if (address.estado == state) {
          products.add(product);
        }
      }
      return products;
    } catch (e) {
      print("Error getting products by state: $e");
      return [];
    }
  }

  Future<Address> getAddressById(String? addressId) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('addresses').doc(addressId).get();
      return Address.fromMap(snapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print("Error getting address by ID: $e");
      rethrow;
    }
  }

  Future<Map<String?, Address>> fetchAllProductAddresses(
      List<Product> products) async {
    Map<String?, Address> productAddress = <String, Address>{};
    for (var product in products) {
      final address = await fetchProductAddress(
          product.addressId); // Chama a função async para buscar o endereço
      if (address != null) {
        productAddress[product.addressId] =
            address; // Armazena o endereço no mapa
      }
    }
    return productAddress;
  }

  Future<Address?> fetchProductAddress(String? addressId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('addresses').doc(addressId).get();

      if (doc.exists) {
        return Address.fromFirestore(doc);
      } else {
        print('Endereço não encontrado');
        return null;
      }
    } catch (e) {
      print('Erro ao buscar o endereço: $e');
      return null;
    }
  }

  Future<String> getContactById(String userId) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(userId).get();
      return snapshot["contato"];
    } catch (e) {
      print("Error getting contato by ID: $e");
      rethrow;
    }
  }

  Future<bool> isUserDataOk() async {
    try {
      User? user = _auth.currentUser;
      if(user != null) {
        DocumentSnapshot userDoc = await _firestore.collection("users").doc(user.uid).get();

        if(userDoc.exists) {
          Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

          List<String> requiredFields = ['nome', 'cpf', 'contato', 'defaultAddressId'];

          for(String field in requiredFields) {
            if(userData[field] == null || userData[field].toString().isEmpty) {
              return false;
            }
          }
          
          return true;
        }
      }
    }
    catch(e) {
      print('Erro ao verificar os dados do usuário: $e');
      return false;
    }
    return false;
  }
}
