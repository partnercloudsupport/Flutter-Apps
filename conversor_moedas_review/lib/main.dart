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
    home: Container()));
}

Future<Map> getData() async {
  // objeto que irá fazer requisição
  http.Response response = await http.get(request);
  // json.decode() converte a string do response.body para um Map
  // retornamos o Map
  return json.decode(response.body);
}
