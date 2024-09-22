import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/controllers/login_controller.dart';
import 'package:trade_now/app/core/constants/color_constants.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = Get.mediaQuery.size.width;
    var screenHeight = Get.mediaQuery.size.height;
    final controller = Get.put(LoginController());
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text(
          "Trade Now",
          style: TextStyle(
              color: lightColor, fontWeight: FontWeight.bold, fontSize: 36),
        ),
        centerTitle: true,
        toolbarHeight: 80,
        backgroundColor: bgColor,
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.only(top: 40),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            decoration: BoxDecoration(
                border: Border.all(color: lightColor, width: 1.0),
                color: darkerColor,
                borderRadius: BorderRadius.circular(4)),
            width: screenWidth * 0.8,
            height: screenHeight * 0.5,
            child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (email) => controller.validateEmail(email),
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: lightColor,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          label: Text("Email"),
                          hintText: "Digite o seu email",
                          suffixIcon: Icon(Icons.email)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: controller.passwordController,
                      validator: (senha) => controller.validatePassword(senha),
                      obscureText: true,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: lightColor,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          label: Text("Senha"),
                          hintText: "Digite a sua senha",
                          suffixIcon: Icon(Icons.password)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                            onPressed: () {
                              Get.toNamed("/register");
                            },
                            child: const Text(
                              "Não tenho conta",
                              style: TextStyle(
                                  color: lightColor,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () => controller.handleLogin(),
                      style: ButtonStyle(
                          fixedSize:
                              const WidgetStatePropertyAll(Size(160, 20)),
                          backgroundColor: WidgetStateProperty.all(bgColor)),
                      child: const Text("Login"),
                    )
                  ],
                )),
          ),
        ),
      ),
      backgroundColor: bgColor,
    );
  }
}
