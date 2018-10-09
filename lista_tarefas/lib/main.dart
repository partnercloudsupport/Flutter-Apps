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
  // Lista que terá as atividades
  List _toDoList = ["Thiago", "Gabriel"];
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
  // Lê os dados
  Future<String> readData() async {
    try {
      // Óbtem o arquivo
      final file = await getFile();
      // lê o arquivo
      return file.readAsString();
    } catch(e) {
      return null;
    }
  }
    // interface do app
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Lista de Tarefas", 
            style: TextStyle(fontSize: 14.0,
            color: Colors.white),
          ),
          backgroundColor: Colors.blueAccent,
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(17.0, 1.0, 1.0, 7.0,),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                        decoration: InputDecoration(
                            labelText: "Nova Tarefa",
                            labelStyle: TextStyle(
                                color: Colors.blueAccent
                            )
                        )
                    ),
                  ),
                  RaisedButton(
                      color: Colors.blueAccent,
                      child: Text("ADD"),
                      onPressed: () {}
                  ),
                ],
              ),
            ),
            // Widget que especificará o tamanho da ListView (Dúvida!)
            Expanded(
              // construtor da ListView
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10.0),
                // quantos itens terá no ListView
                itemCount: _toDoList.length,
                // index é o indice do elemento da lista que ele está desenhando no momento
                itemBuilder: (context, index){
                  return CheckboxListTile(
                    // O valor virá do map
                    value: _toDoList[index]["ok"],
                    // o titulo do ListTile será o texto na posição index do _toDoList
                    title: Text(_toDoList[index]),
                    secondary: CircleAvatar(
                      // Se toDoList[index]["ok"] for true, usamos o icon check se for
                      // false usamos o icon de errro
                      child: Icon(_toDoList[index]["ok"] ? Icons.check
                      : Icons.error),),
                    );
                }),
            )
          ],
        )
      );
    }
}