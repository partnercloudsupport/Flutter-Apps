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
  // ler os dados sempre que o app iniciar
  @override
  void initState() {
    super.initState();
    readData().then((data) {
      setState(() {
        _toDoList = json.decode(data);
      });
    });
  }

  @override
  // Lista que terá as atividades
  List _toDoList = [];
  final dataController = TextEditingController();

  Map<String, dynamic> lastRemoved = Map();
  int lastRemovedPosition;

  // interface do appx
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Lista de Tarefas",
            style: TextStyle(fontSize: 14.0, color: Colors.white),
          ),
          backgroundColor: Colors.blueAccent,
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(
                17.0,
                1.0,
                1.0,
                7.0,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                        controller: dataController,
                        decoration: InputDecoration(
                            labelText: "Nova Tarefa",
                            labelStyle: TextStyle(color: Colors.blueAccent))),
                  ),
                  RaisedButton(
                      color: Colors.blueAccent,
                      child: Text("ADD"),
                      onPressed: addToDo // chama a função de add tarefa
                      ),
                ],
              ),
            ),
            // Widget que especificará o tamanho da ListView (Dúvida!)
            Expanded(
                child: ListView.builder(
              // construtor da ListView
              padding: EdgeInsets.only(top: 10.0),
              itemCount: _toDoList.length,
              // quantos itens terá no ListView
              // index é o indice do elemento da lista que ele está desenhando no momento
              itemBuilder: buildItem,
            ))
          ],
        ));
  }

  // Essa função irá adicionar a atividade a lista _toDoList
  void addToDo() {
    setState(() {
      Map<String, dynamic> newToDo = Map(); // instanciamos um map vazio
      newToDo["title"] = dataController
          .text; // pegamos o texto do TextField e armazenamos num map
      dataController.text = ""; // limpamos TextField
      newToDo["ok"] =
          false; // como estamos criando a atividade, o estado ok dela é false
      _toDoList.add(newToDo); // adicionamos o map a lista toDoList
      saveData();
    });
  }

  Future<File> getFile() async {
    // obtém o diretório do app, como o endereço não é retornado na hora
    // usamos o await
    final directory = await getApplicationDocumentsDirectory();
    return File(
        "${directory.path}/data.json"); // retorna o arquivo data.json no diretório directory
  }

  // salva os dados
  Future<File> saveData() async {
    String data = json.encode(_toDoList); // converte a list para json
    final file = await getFile(); // o arquivo file recebe o arquivo
    return file
        .writeAsString(data); // escrevemos os dados (data) no arquivo (file)
  }

  // Lê os dados
  Future<String> readData() async {
    try {
      final file = await getFile(); // Óbtem o arquivo
      return file.readAsString(); // lê o arquivo
    } catch (e) {
      return null;
    }
  }

  // essa função faz os itens do ListView
  Widget buildItem(context, index) {
    
    return Dismissible(
      // usamos para diferenciar os elementos da ListView
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.red,
        alignment: Alignment(-0.9, 0.0),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      child: CheckboxListTile(
        value: _toDoList[index]["ok"],
        // O valor virá do map
        // o titulo do ListTile será o texto na posição index do _toDoList
        title: Text(_toDoList[index]["title"]),
        secondary: CircleAvatar(
          // Se toDoList[index]["ok"] for true, usamos o icon check se for
          child: Icon(_toDoList[index]["ok"]
              ? Icons.check
              : Icons.error), // false usamos o icon de errro
        ),
        // chama uma função quando o estado do checkbox é alterado
        onChanged: (c) {
          // o parametro c é o estado do checkBox (true or false)
          setState(() {
            _toDoList[index]["ok"] = c; // passamos o estado para o campo "ok" da lista
            saveData(); // salva os dados
          });
        },
      ),
      onDismissed:(direction){
        lastRemoved = Map.from(_toDoList[index]);
        lastRemovedPosition = index;
        _toDoList.removeAt(index); // removemos o elemento corrente

        setState(() {
          saveData(); // salvamos
        });
      },
    );
  }
}
