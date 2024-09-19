import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future handleLogin() async {
    if (formKey.currentState!.validate()) {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        Get.snackbar("Sucesso", "Você foi logado com sucesso!",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.green);
        Future.delayed(const Duration(seconds: 1), () => Get.toNamed("/home"));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.snackbar("Usuário não encontrado",
              "Não existe nenhum usuário com as credenciais informadas!",
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.red);
        } else if (e.code == 'wrong-password') {
          Get.snackbar("Senha errada", "A senha informada está incorreta!",
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.red);
        }
      }
    }
  }

  String? validatePassword(String? password) {
    if (GetUtils.isLengthLessThan(password, 8)) {
      return "A senha deve conter no mínimo 8 caracteres!";
    }

    return null;
  }

  String? validateEmail(String? email) {
    if (!GetUtils.isEmail(email ?? "")) {
      return "O email fornecido é inválido";
    }
    return null;
  }
}
