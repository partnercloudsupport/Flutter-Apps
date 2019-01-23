import 'package:flutter/material.dart';
import 'package:loja_online_aula/screens/home_screen.dart';
import 'package:loja_online_aula/widgets/custom_drawer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loja Online',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromARGB(255, 4, 125, 141)
      ),
      debugShowCheckedModeBanner: false,
      // usamos o Scaffold pois o Drawer necessita de estar dentro do Scaffold
      home: Scaffold(
        body: HomeScreen(),
        drawer: Custom_Drawer(),
      ), // tela principal do app
    );
  }
}