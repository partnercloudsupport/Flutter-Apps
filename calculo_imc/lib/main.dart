import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightCrontroller = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // chave global

  String _infoText = "Informe seu peso";

  // Reseta os campos da tela principal
  void _resetFields() {
    weightCrontroller.text = " ";
    heightController.text = " ";
    setState(() {
      _infoText = "Informe seu peso";
    });
  }

  // Calcula o IMC
  void _calculate() {
    setState(() {
      double weight = double.parse(weightCrontroller.text);
      double height =
          double.parse(heightController.text) / 100; // passar m pra cm
      double imc = weight / (height * height);

      if (imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true, // alinha o titulo para o centro
          backgroundColor: Colors.green, // muda a cor da barra do AppBar
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  _resetFields();
                  debugPrint("Refresh");
                }),
          ],
        ),
        // Cor de background
        backgroundColor: Colors.white,
        // Corpo do App
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
              key:
                  _formKey, // passamos a key dentro do Form!!! (Passei dentro da coluna e deu erro!!!)
              child: Column(
                // aqui estamos criando o corpo do app
                crossAxisAlignment: CrossAxisAlignment.stretch,
                // aqui fazemos os widgets ocupar to_do o espaço da parte horizontal da coluna
                children: <Widget>[
                  Icon(
                    Icons.person_outline,
                    size: 120.0,
                    color: Colors.green,
                  ), // aqui estamos colocando o incone
                  // Weigth
                  TextFormField(
                    keyboardType: TextInputType
                        .number, // caixa de texto para receber numeros
                    decoration: InputDecoration(
                        // decoração da caixa de texto
                        labelText: "Peso (Kg)", // decoramos com um labelText
                        labelStyle: TextStyle(
                          color: Colors.green,
                          fontSize: 25.0,
                        )),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                    controller: weightCrontroller,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira seu peso!";
                      }
                    },
                  ),
                  // height
                  TextFormField(
                      keyboardType: TextInputType
                          .number, // caixa de texto para receber numeros
                      decoration: InputDecoration(
                          // decoração da caixa de texto
                          labelText:
                              "Altura (cm)", // decoramos com um labelText
                          labelStyle: TextStyle(
                            color: Colors.green,
                            fontSize: 25.0,
                          )),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontSize: 25.0),
                      controller: heightController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira sua altura!";
                        }
                      }),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calculate();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Text(_infoText,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontSize: 25.0))
                ],
              ),
            )));
  }
}
