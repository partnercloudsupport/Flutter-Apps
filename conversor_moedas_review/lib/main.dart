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
  runApp(
    MaterialApp(
        home: Home(),
        // tema do app
        theme: ThemeData(
          hintColor: Colors.amber,
          primaryColor: Colors.white,
        )),
  );
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
  // controladores dos TextFields
  // usamos final pois não irá mudar os textos (Dúvida!)
  TextEditingController realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();
  // funções que converterão os valores, o parametro text é o texto que mudou no 
  // TextField
  void _realChanged(String text) {
    // obtendo o valor digitado no campo de reais
    double real = double.parse(text);
    // conversão dolar = real / dolar
    dolarController.text = (real/dolar).toStringAsFixed(2);
    // conversão euro = real / euro
    euroController.text = (real/euro).toStringAsFixed(2);
  }
  // text = o texto modificado no TextField do dolar
  void _dolarChanged(String text) {
    double dolar = double.parse(text);
    realController.text = (this.dolar * dolar).toStringAsFixed(2);
    euroController.text = ((dolar * this.dolar) / euro).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    double euro = double.parse(text);
    realController.text = (this.euro * euro).toStringAsFixed(2);
    dolarController.text = ((euro * this.euro) / dolar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        // barra do app
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "\$ Conversor \$",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
                color: Colors.black),
          ),
          backgroundColor: Colors.amber,
        ),
        // O FutureBuilder construirá a tela de acordo com o estado do future
        body: FutureBuilder<Map>(
            // O dado que será obtido no futuro
            future: getData(),
            //
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                // ConnectionState.none e .waiting significa quer a conexão não
                // foi recebida / esperando
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: Text(
                      "Carregando dados...",
                      style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.amber,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                default:
                  // Testa se a conexão teve erro, se tiver aparecer mensagem de erro
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Erro ao carregar",
                        style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.amber,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  } else {
                    // atribuindo o valor de compra do dolar e do euro
                    // formato json
                    dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                    euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                    // interface do app
                    return SingleChildScrollView(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(
                            Icons.monetization_on,
                            color: Colors.amber,
                            size: 140.0,
                          ),
                          // Criação dos TextFields com o buildTextField
                          // TextField reais
                          buildTextField("Reais", "R\$ ", realController, _realChanged),
                          // TextField dolares
                          Divider(),
                          buildTextField("Dólares", "US\$ ", dolarController, _dolarChanged),
                          // TextField Euros
                          Divider(),
                          buildTextField("Euros", "EUR ", euroController, _euroChanged),
                        ],
                      ),
                    );
                  }
              }
            }));
  }
}

// funçao que retorna um Widged
Widget buildTextField(String label, String prefix, TextEditingController controller, Function function) {
  // retornamos o TextField, onde só irá mudar o labelText e o prefixText
  return TextField(
    keyboardType: TextInputType.number,
    // instanciamos o controlador passado no parametro
    controller: controller,
    decoration: InputDecoration(
      // passamos os textos dos parametros para o labelText e prefixText
      labelText: label,
      prefixText: prefix,
      labelStyle: TextStyle(
        color: Colors.amber,
        fontSize: 18.0,
      ),
      border: OutlineInputBorder(),
    ),
    // estilo do texto dentro do TextField
    style: TextStyle(color: Colors.amber, fontSize: 24.0),
    // quando o TextField mudar, chamar a função function passada no parametro
    onChanged: function,
  );
}
