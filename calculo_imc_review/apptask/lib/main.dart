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
      // cor de fundo do app
      backgroundColor: Colors.blueGrey,
        // Barra do app com texto
        appBar: AppBar(
      title: Text("Calculadora IMC"),
      centerTitle: true,
          backgroundColor: Colors.lightBlue[800],
          // onde irá acontecer as ações da AppBar
          actions: <Widget>[
            // IconButton se comporta igual o Button
            IconButton(
              icon: Icon(Icons.refresh, color: Colors.black,),
              onPressed: () {
                debugPrint("Refresh");
              },
            )
          ],
    ),
    body: Column(
      // Alinha os filhos da coluna no centro (não entendi pq stretch)
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
      Icon(Icons.person, size: 240.0,)
    ],),
    );
  }
}
