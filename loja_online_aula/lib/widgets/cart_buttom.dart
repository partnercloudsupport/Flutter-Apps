import 'package:flutter/material.dart';
import 'package:loja_online_aula/screens/cart_screen.dart';

/*
* Widget que usaremos para chamar a tela de carrinho
* */

class CartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      child: Icon(Icons.shopping_cart, color: Colors.white),
      onPressed: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => CartScreen()
          )
        );
      },
    );
  }
}
