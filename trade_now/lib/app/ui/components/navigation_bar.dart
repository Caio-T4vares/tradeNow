import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_now/app/core/constants/color_constants.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Buscar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle),
          label: 'Anunciar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        )
      ],
      backgroundColor: darkerColor,
    );
  }
}
// Column(
//           children: [Icon(Icons.home), Text("Home")],
//         ),
//         Column(
//           children: [Icon(Icons.search), Text("Search")],
//         ),
//         Column(
//           children: [Icon(Icons.add_circle), Text("Annoucement")],
//         ),
//         Column(
//           children: [Icon(Icons.person), Text("Perfil")],
//         )