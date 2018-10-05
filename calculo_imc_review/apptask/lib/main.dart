import 'package:flutter/material.dart';

// start of a project

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

// A Widget Stateful where it will be pass like argument to runApp -> home:
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // Widget Scaffold
    return Scaffold(
        // Barra do app com texto
        appBar: AppBar(
      title: Text("Calculadora IMC"),
      centerTitle: true,
          backgroundColor: Colors.amber,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.playlist_play),
              onPressed: () {
                debugPrint("botao apertado");
              },
            )
          ],
    ));
  }
}
