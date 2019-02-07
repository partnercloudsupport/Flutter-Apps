import 'package:flutter/material.dart';
import 'package:loja_online_aula/models/cart_model.dart';
import 'package:loja_online_aula/models/user_model.dart';
import 'package:loja_online_aula/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Colocamos como Widget principal o ScopedModel para que possamos utulizar todos
    // os atributos e a as funções do model UserModel em to.do o app.
    return ScopedModel<UserModel>(
      model: UserModel(), // estamos especificando que usaremos em t.odo o app o model UserModel
      child: ScopedModelDescendant<UserModel>(
  /*
  * IMPORTANTE: Estamos usando um ScopedModelDescendant para poder passar o model UserModel
  * para o CartModel, pois queremos atualizar o carrinho caso mude de usuário.
  *
  * */
          builder: (context, child, model) {
            return ScopedModel<CartModel>(
              model: CartModel(model),
              child: MaterialApp(
                  title: 'Loja Online',
                  theme: ThemeData(
                      primarySwatch: Colors.blue,
                      primaryColor: Color.fromARGB(255, 4, 125, 141)
                  ),
                  debugShowCheckedModeBanner: false,
                  home: HomeScreen() // tela principal do app
              ),
            );
          }
      )
    );
  }
}