import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:trade_now/app/core/constants/color_constants.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Trade Now",
          style: TextStyle(color: lightColor),
        ),
        centerTitle: true,
        toolbarHeight: 80,
        backgroundColor: darkerColor,
      ),
      body: Form(
          child: SizedBox(
        width: 400,
        height: 300,
        child: Column(
          children: [
            Column(
              children: [const Text("Email"), TextFormField()],
            ),
            Column(
              children: [
                const Text("Senha"),
                TextFormField(),
              ],
            ),
            ElevatedButton(onPressed: () {}, child: const Text("Login"))
          ],
        ),
      )),
      backgroundColor: bgColor,
    );
  }
}
