import 'package:flutter/material.dart';
import 'package:trade_now/app/core/constants/color_constants.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: const [
        Column(
          children: [Icon(Icons.home), Text("Home")],
        ),
        Column(
          children: [Icon(Icons.search), Text("Search")],
        ),
        Column(
          children: [Icon(Icons.add_circle), Text("Annoucement")],
        ),
        Column(
          children: [Icon(Icons.person), Text("Perfil")],
        )
      ],
      backgroundColor: darkerColor,
    );
  }
}
