import 'package:flutter/material.dart';
// biblioteca de requisições da internet
import 'package:http/http.dart' as http;
// bliblioteca que permite fazer requisições e não travar o programa enquato espera
import 'dart:async';

// link de requisição da api de conversão de moedas
const request = "https://api.hgbrasil.com/finance/?=format=json&key=60df7606";

void main() async {
  // usamos o await para esperar os dados serem obtidos
  // para isso nossa função deve ser async!
  http.Response response = await http.get(request);
  print(response.body);

  runApp(MaterialApp(
    home: Container()));
}