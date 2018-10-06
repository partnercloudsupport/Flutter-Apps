import 'package:flutter/material.dart';
// biblioteca de requisições da internet
import 'package:http/http.dart' as http;
// bliblioteca que permite fazer requisições e não travar o programa enquato espera
import 'dart:async';
// biblioteca que permite converter a string para um json (um map)
import 'dart:convert';

// link de requisição da api de conversão de moedas
const request = "https://api.hgbrasil.com/finance/?=format=json&key=60df7606";

  // usamos o await para esperar os dados serem obtidos
  // para isso nossa função deve ser async!
void main() async {
  runApp(MaterialApp(
    home: Home()));
}

Future<Map> getData() async {
  // objeto que irá fazer requisição
  http.Response response = await http.get(request);
  // json.decode() converte a string do response.body para um Map
  // retornamos o Map
  return json.decode(response.body);
}
// Widget Stateful
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // variavel que armazenará os dados das moedas
  double dolar;
  double euro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // barra do app
      appBar: AppBar(
        centerTitle: true,
        title: Text("\$ Conversor \$", style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
          color: Colors.black
        ),),
        backgroundColor: Colors.amber,
      ),
      // O FutureBuilder construirá a tela de acordo com o estado do future
      body: FutureBuilder<Map>(
        // O dado que será obtido no futuro
        future: getData(),
        // 
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            // ConnectionState.none e .waiting significa quer a conexão não
            // foi recebida / esperando
            case ConnectionState.none :
            case ConnectionState.waiting :
              return Center(
                child: Text("Carregando dados...", 
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.amber,
                    fontWeight: FontWeight.bold
                  ),
                ),
              );
            default: 
            // Testa se a conexão teve erro, se tiver aparecer mensagem de erro
              if (snapshot.hasError) {
                return Center(
                  child: Text("Erro ao carregar", 
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.amber,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                );
              } else {
                  // atribuindo o valor de compra do dolar e do euro
                  // formato json
                  dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                  // interface do app
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(Icons.monetization_on, color: Colors.amber, size: 140.0,),
                        TextField(decoration: InputDecoration(
                          labelText: "Reais",
                          prefixText: "R\$",
                          labelStyle: TextStyle(
                            color: Colors.amber,
                            fontSize: 18.0,
                          ),
                        border: OutlineInputBorder(),
                        ),)
                      ],
                    ),);
              }
          }
        }
        )
    );
  }
}

