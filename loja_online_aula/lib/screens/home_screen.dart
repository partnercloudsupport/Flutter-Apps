import 'package:flutter/material.dart';
import 'package:loja_online_aula/tabs/home_tab.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController(); // controlador das telas

  @override
  Widget build(BuildContext context) {
    return PageView( // widget que permite navegar por telas
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(), // desabilita função de rolar pro lado a tela
      children: <Widget>[
        HomeTab(),
      ],
    );
  }
}
