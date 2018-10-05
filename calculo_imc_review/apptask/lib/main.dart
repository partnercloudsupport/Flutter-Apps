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
      // O uso do stretch é para ele alinhar o eixo cruzado
      // como o eixo principal da coluna é o vertical, o stretch vai alinhar
      // no eixo cruzado, o horizontal, ocupando todo o espaço horizontal da coluna
      crossAxisAlignment: CrossAxisAlignment.stretch,
      // children: Icon, TextField
      children: <Widget>[
      Icon(Icons.person_outline, size: 140.0, color: Colors.lightBlue[800],),
      // Caixa de texto
      TextField(keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
        // Esse style é para o texto digitado no campo
        style: TextStyle( fontSize: 24.0, color: Colors.black),
        // decoração do TextField
        decoration: InputDecoration(labelText: "Peso (kg)",
          labelStyle: TextStyle(color: Colors.black, fontSize: 24.0,
            fontWeight: FontWeight.bold)
        ),
      ),
      TextField(keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        // Esse style é para o texto digitado no campo
        style: TextStyle( fontSize: 24.0, color: Colors.white),
        // decoração do TextField
        decoration: InputDecoration(labelText: "Altura (metros)",
          labelStyle: TextStyle(color: Colors.black, fontSize: 24.0,
            fontWeight: FontWeight.bold
            )
          ),
        ),
        RaisedButton(
          color: Colors.lightBlue[800],
          onPressed: () {},
          child: Text("Calcular", style: TextStyle(fontSize: 22.0, color: Colors.black)
          ,) 
        )
    ],),
    );
  }
}
