import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/controllers/login_controller.dart';
import 'package:trade_now/app/constants/color_constants.dart';

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
                border: Border.all(color: green6, width: 1.0),
                color: green4,
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
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          fillColor: green5,
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
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
                      validator: (senha) => controller.validatePassword(senha),
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
                            Icons.password,
                            color: green6,
                          )),
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
                                  color: green6, fontWeight: FontWeight.bold),
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
      backgroundColor: green6,
    );
  }
}
