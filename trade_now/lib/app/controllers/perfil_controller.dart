import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class PerfilController extends GetxController {
  TextEditingController nomeController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  Rx<File?> selectedImage = Rx<File?>(null); 

  @override
  void onInit() {
    super.onInit();
    _carregarDadosDoUser(); // Carrega os dados ao iniciar a tela
  }

  Future<void> _carregarDadosDoUser() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await _firestore.collection("users").doc(user.uid).get();
        
        if (userDoc.exists) {
          Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

          // Preenche os controladores com os dados salvos, se existirem
          nomeController.text = userData['nome'] ?? '';
          cpfController.text = userData['cpf'] ?? '';
          contactController.text = userData['contato'] ?? '';

          String? fotoPerfilUrl = userData['fotoPerfilPath'];
          if (fotoPerfilUrl != null && fotoPerfilUrl.isNotEmpty) {
            // Se a URL da imagem não estiver vazia, use-a
            selectedImage.value = await _baixarImagem(fotoPerfilUrl);
          }
        }
      }
    }
    catch(e) {
      Get.snackbar("Erro", "Erro ao carregar dados: $e");
    }
  }

  Future<File?> _baixarImagem(String url) async {
  try {
    // Usar o pacote http ou dio para baixar a imagem
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // Salvar a imagem em um arquivo local
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/foto_perfil.png';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return file; // Retornar o arquivo baixado
    }
  } catch (e) {
    Get.snackbar("Erro", "Erro ao baixar imagem: $e");
  }
  return null;
}

  Future<void> salvarDados() async {
    try {
      User? user = _auth.currentUser;
      if(user != null) {
        String uid = user.uid;

        String? fotoPerfilUrl;
        if (selectedImage.value != null) {
          await uploadImagem(); // Faz o upload da imagem
          fotoPerfilUrl = await _storage.ref().child("images/$uid/profile_pic").getDownloadURL(); // Obtém a URL após o upload
        }

        Map<String, dynamic> userData = {
          'nome': nomeController.text,
          'cpf': cpfController.text,
          'contato': contactController.text,
          'enderecos': [],
          'fotoPerfilPath': fotoPerfilUrl
        };

        await _firestore.collection('users').doc(uid).set(userData, SetOptions(merge: true));
        Get.snackbar('Sucesso!', "Dados salvos com sucesso!");
      }
    }
    catch(e) {
      Get.snackbar('Erro', 'Erro ao salvar dados: $e');
    }
  }

  Future<void> selecionarImagem() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
      await uploadImagem(); // Faça o upload após a seleção
    }
  }


  Future<void> uploadImagem() async {
    try {
      User? user = _auth.currentUser;

      if (user != null && selectedImage.value != null) {
        String uid = user.uid;

        // Caminho de armazenamento no Firebase Storage
        Reference storageRef = _storage.ref().child("images/$uid/profile_pic");

        // Upload da imagem
        UploadTask uploadTask = storageRef.putFile(selectedImage.value!);
        TaskSnapshot taskSnapshot = await uploadTask;

        // Obter URL da imagem
        String downloadURL = await taskSnapshot.ref.getDownloadURL();

        // Atualiza o Firestore com o URL da imagem
        await _firestore.collection("users").doc(uid).update({
          "fotoPerfilPath": downloadURL,
        });

        //Get.snackbar("Sucesso", "Imagem de perfil atualizada!");
      } else {
        Get.snackbar("Erro", "Selecione uma imagem para continuar");
      }
    } catch (e) {
      Get.snackbar("Erro", "Erro ao fazer upload da imagem: $e");
    }
  }
}