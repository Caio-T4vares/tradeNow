import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:http/http.dart' as http;
import 'package:trade_now/app/model/product.dart';

class AnnouncementController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  Rx<String> selectedCategory = 'Eletrônicos'.obs;
  Rx<String> selectedCondition = 'Novo'.obs;

  RxList<Product> userProducts = <Product>[].obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  final ImagePicker _picker = ImagePicker();
  RxList<File> selectedImages = <File>[].obs;

  Future<void> salvarAnuncio() async {
    try {
      User? user = _auth.currentUser;

      if(user != null && selectedImages.isNotEmpty) {
        DocumentReference productRef = _firestore.collection('products').doc();
        String productId = productRef.id;

        List<String>? imageUrls = await uploadImagens(productId);
        Product product = Product(
          id: productId,
          name: titleController.text,
          description: descriptionController.text,
          price: double.tryParse(priceController.text),
          condition: selectedCondition.value,
          category: selectedCategory.value,
          imgsUrl: imageUrls,
        );

        await productRef.set({
          'id': product.id,
          'name': product.name,
          'description': product.description,
          'condition': product.condition,
          'category': product.category,
          'price': product.price,
          'imgUrls': product.imgsUrl,
          'userId': user.uid
        });

        Get.snackbar("Sucesso", "Anúncio salvo com sucesso!");
      }
      else {
        Get.snackbar("Erro", "Selecione pelo menos uma imagem para o anúncio");
      }
    }
    catch(e) {
       Get.snackbar("Erro", "Erro ao salvar o anúncio: $e");
    }
  }

  Future<void> selecionarImagens() async {
    final List<XFile> images = await _picker.pickMultiImage(imageQuality: 75);

    if (images.length <= 3) {
      List<File> compressedImages = [];

      for (XFile image in images) {
        File imageFile = File(image.path);
        XFile? compressedImage = await compressImage(imageFile);

        if (compressedImage != null) {
          compressedImages.add(File(compressedImage.path));
        }
      }

      selectedImages.value = compressedImages; // Atualiza a lista de imagens selecionadas
    } else {
      Get.snackbar("Erro", "Você pode selecionar até 3 imagens.");
    }
  }

  Future<List<String>?> uploadImagens(String productId) async {
    try {
      List<String> imageUrls = [];
      
      for(File image in selectedImages) {
        String imagePath = 'images/$productId/${image.path.split('/').last}';
        Reference storageRef = _storage.ref().child(imagePath);
        UploadTask uploadTask = storageRef.putFile(image);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadURL = await taskSnapshot.ref.getDownloadURL();
        imageUrls.add(downloadURL);
      }

      return imageUrls;
    } catch (e) {
      Get.snackbar("Erro", "Erro ao fazer upload das imagens: $e");
    }
    return null;
  }

  Future<void> baixarImagens(List<String> imageUrls) async {
    List<File> downloadedImages = [];

    for (String url in imageUrls) {
      File? file = await _baixarImagem(url);
      if (file != null) {
        downloadedImages.add(file);  // Adiciona à lista de imagens baixadas
      }
    }

    selectedImages.value = downloadedImages;  // Atualiza as imagens no controller
  }

  Future<File?> _baixarImagem(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final directory = await getTemporaryDirectory();
        final filePath = '${directory.path}/image_${url.split('/').last}';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        return file; // Retorna o arquivo baixado
      }
    } catch (e) {
      Get.snackbar("Erro", "Erro ao baixar imagem: $e");
    }
    return null;
  }

  Future<XFile?> compressImage(File imageFile) async {
    final directory = await getTemporaryDirectory();
    final targetPath = '${directory.path}/compressed_${imageFile.path.split('/').last}';

    // Comprime a imagem
    var result = await FlutterImageCompress.compressAndGetFile(
      imageFile.absolute.path,
      targetPath,
      quality: 20,
    );

    return result;
  }

  Future<void> getUserProducts() async {
    try {
      User? user = _auth.currentUser;
      if(user != null) {
        QuerySnapshot snapshot = await _firestore
            .collection('products')
            .where('userId', isEqualTo: user.uid)
            .get();

        List<Product> products = snapshot.docs.map((doc) {
          return Product(
            name: doc['name'],
            description: doc['description'],
            price: doc['price'].toDouble(),
            condition: doc['condition'],
            category: doc['category'],
            imgsUrl: List<String>.from(doc['imgUrls'] ?? []),
          );
        }).toList();

        userProducts.value = products;
      }
      else {
        Get.snackbar("Erro", "Usuário não autenticado.");
      }
    }
    catch(e) {
      Get.snackbar("Erro", "Erro ao buscar anúncios: $e");
    }
  }
}