import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/controllers/register_controller.dart';
import 'package:trade_now/app/constants/color_constants.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = Get.mediaQuery.size.width;
    var screenHeight = Get.mediaQuery.size.height;
    final controller = Get.put(RegisterController());
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text(
          "Trade Now",
          style: TextStyle(
              color: green6, fontWeight: FontWeight.bold, fontSize: 36),
        ),
        centerTitle: true,
        toolbarHeight: 80,
        backgroundColor: green4,
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.only(top: 40),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            decoration: BoxDecoration(
                border: Border.all(color: lightColor, width: 1.0),
                color: green4,
                borderRadius: BorderRadius.circular(4)),
            width: screenWidth * 0.8,
            height: screenHeight * 0.5,
            child: SingleChildScrollView(
              child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (email) => controller.validateEmail(email),
                        decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            filled: true,
                            fillColor: green5,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            label: Text(
                              "Email",
                              style: TextStyle(color: green6),
                            ),
                            hintText: "Digite o seu email",
                            suffixIcon: Icon(
                              Icons.email,
                              color: green6,
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: controller.passwordController,
                        validator: (senha) =>
                            controller.validatePassword(senha),
                        obscureText: true,
                        decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            filled: true,
                            fillColor: green5,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            label: Text(
                              "Senha",
                              style: TextStyle(color: green6),
                            ),
                            hintText: "Digite a sua senha",
                            suffixIcon: Icon(
                              Icons.visibility,
                              color: green6,
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: controller.confirmPasswordController,
                        validator: (confirmPwd) =>
                            controller.validadeConfirmPwd(confirmPwd),
                        obscureText: true,
                        decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            filled: true,
                            fillColor: green5,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            label: Text(
                              "Confirme a sua senha",
                              style: TextStyle(color: green6),
                            ),
                            hintText: "Digite a sua senha novamente",
                            suffixIcon: Icon(
                              Icons.visibility,
                              color: green6,
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () => controller.handleRegister(),
                        style: ButtonStyle(
                            fixedSize:
                                const WidgetStatePropertyAll(Size(160, 20)),
                            backgroundColor: WidgetStateProperty.all(green3)),
                        child: const Text(
                          "Login",
                          style: TextStyle(color: green6),
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
      backgroundColor: green6,
    );
  }
}
