import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future handleRegister() async {
    if (formKey.currentState!.validate()) {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Get.snackbar("Sucesso", "Você foi registrado com sucesso!",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.green);
        Future.delayed(const Duration(seconds: 1), () => Get.toNamed("/home"));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          Get.snackbar("Conta já existe", "A conta informada já existe!",
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

  String? validadeConfirmPwd(String? confirmPwd) {
    if (confirmPwd != passwordController.text) {
      return "O campo deve ter o mesmo valor do campo 'Senha'";
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
