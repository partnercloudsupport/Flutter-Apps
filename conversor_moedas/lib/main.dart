import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.promasters.net.br/cotacao/v1/valores";

void main() async {

  // Estou printando o que minha função getData retorna (um Map)
  print(await getData());

  runApp(MaterialApp(
    home: Home()
  ));
}

// getData é a função que retorna um Map
Future<Map> getData() async {
  // http é um dado futuro
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  double dolar = 0.0;
  double euro = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // cor de fundo do Scaffold
      backgroundColor: Colors.amber,
      // A barra do topo do app
      appBar: AppBar(
        // Texto da barra
        title: Text("\$ Conversor \$", style: TextStyle(color: Colors.black, fontSize: 25.0)),
        // cor da barra
        backgroundColor: Colors.yellowAccent,
        centerTitle: true
        ),
        body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch(snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center( // ao caso de esperar os dados
                  child: Text("Carregando dados...",
                    style: TextStyle(color: Colors.amber,
                        fontSize: 25.0), textAlign: TextAlign.center,),
                );
              default:
                if(snapshot.hasError){ // caso tenha erro ao obter o dado retornar mensagem de erro
                  return Center(
                    child: Text("Erro ao carregar dados",
                      style: TextStyle(color: Colors.amber,
                          fontSize: 25.0), textAlign: TextAlign.center,),
                  );
                } else {
                  dolar = snapshot.data["valores"]["USD"]["valor"];
                  euro = snapshot.data["valores"]["EUR"]["valor"];
                  return SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.monetization_on, size: 150.0, color: Colors.black,),

                      ],
                    ),
                  );
                }
            }
          },
        )
      );
  }
}



