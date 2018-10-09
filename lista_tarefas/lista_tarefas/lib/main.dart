import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
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

  @override

  List _toDoList = [];

  // Função que irá retornar o arquivo
  Future<File> getFile() async {
  // obtém o diretório do app, como o endereço não é retornado na hora
  // usamos o await
    final directory = await getApplicationDocumentsDirectory();
  // retorna o arquivo data.json no diretório directory
    return File("${directory.path}/data.json");
  }
  // salva os dados
  Future<File> saveData() async {
    // converte a list para json
    String data = json.encode(_toDoList);
    // o arquivo file recebe o arquivo
    final file = await getFile();
    // escrevemos os dados (data) no arquivo (file)
    return file.writeAsString(data);
  }
    Widget build(BuildContext context) {
      return Container();
    }
}