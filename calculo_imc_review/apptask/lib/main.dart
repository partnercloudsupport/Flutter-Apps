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
  // funcionalidades
  // decalaração dos controladores
  TextEditingController weightController = TextEditingController(); // controlador do peso
  TextEditingController heightController = TextEditingController(); // controlador da altura

  String textInfo = "Preencha os campos";

  // função que reseta os campos
  void _resetField() {
    setState(() {
      weightController.text = " ";
      heightController.text = " ";
      textInfo = "Preencha os campos";
    });
  }
  // função que calcula o IMC
  void _calculate() {
    setState(() {
      double height = double.parse(heightController.text);
      double weight = double.parse(weightController.text);
      double imc = weight / height;

      if(imc < 18.6) {
        textInfo = "abaixo do peso";
      }else {
        textInfo = "peso normal ou acima";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Widget Scaffold
    return Scaffold(
      // cor de fundo do app
      backgroundColor: Colors.lightBlue[800],
        // Barra do app com texto
        appBar: AppBar(
      title: Text("Calculadora IMC"),
      centerTitle: true,
          backgroundColor: Colors.blueGrey,
          // onde irá acontecer as ações da AppBar
          actions: <Widget>[
            // IconButton se comporta igual o Button
            IconButton(
              icon: Icon(Icons.refresh, color: Colors.black,),
              onPressed: _resetField // função que reseta os campos 
            )
          ],
    ),
    // Esse Widget permite rolar a tela quando o app precisar
    // só tem um child
    body: Padding(
      padding: EdgeInsets.all(10.0),
      child: SingleChildScrollView(
      child: Column(
      // Alinha os filhos da coluna no centro (não entendi pq stretch)
      // O uso do stretch é para ele alinhar o eixo cruzado
      // como o eixo principal da coluna é o vertical, o stretch vai alinhar
      // no eixo cruzado, o horizontal, ocupando todo o espaço horizontal da coluna
      crossAxisAlignment: CrossAxisAlignment.stretch,
      // children: Icon, TextField
      children: <Widget>[
      Icon(Icons.person, size: 140.0, color: Colors.blueGrey,),
      // Caixa de texto
      TextField(keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
        // Esse style é para o texto digitado no campo
        style: TextStyle( fontSize: 24.0, color: Colors.black),
        // decoração do TextField
        decoration: InputDecoration(labelText: "Peso (kg)",
          labelStyle: TextStyle(color: Colors.white, fontSize: 24.0,
            fontWeight: FontWeight.bold)
        ),
        // Estou especificando que este será o controlador deste TextField        
        controller: weightController,
      ),
      TextField(keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        // Esse style é para o texto digitado no campo
        style: TextStyle( fontSize: 24.0, color: Colors.white),
        // decoração do TextField
        decoration: InputDecoration(labelText: "Altura (metros)",
          labelStyle: TextStyle(color: Colors.white, fontSize: 24.0,
            fontWeight: FontWeight.bold
            )
          ),
          // Estou especificando que este será o controlador deste TextField
          controller: heightController,
        ),
        // Padding no botao para espaçar o texto de baixo
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
          // O botao ficará dentro do container para podermos mudarmos seu tamanho
          child: Container(
            height: 80.0,
            child: RaisedButton(
              color: Colors.blueGrey,
              onPressed: _calculate,
                child: Text("Calcular", style: TextStyle(fontSize: 22.0, color: Colors.white,
                  fontWeight: FontWeight.bold
                  )
                ,) 
            ),
          ),
        ),
        Text(textInfo, 
          style: TextStyle(fontSize: 32.0, color: Colors.white),
          textAlign: TextAlign.center,
        )
    ],),
    )
    )
    );
  }
}
