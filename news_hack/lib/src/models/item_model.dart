// Classe para armazenar os itens da API 

import 'dart:convert';

class ItemModel { 
  final int id;
  final bool deleted;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final int parent;
  final List<dynamic> kids;
  final String url;
  final int score;
  final String title;
  final int descendants;

  // Atençõa na Notação!
  // Armaneza a informação do arquivo json na classe
  ItemModel.fromJson(Map<String, dynamic> parsedJson)
    : id =parsedJson['id'],
      deleted =parsedJson['deleted'],
      type =parsedJson['type'],
      by =parsedJson['by'],
      time =parsedJson['time'],
      text =parsedJson['text'],
      dead =parsedJson['dead'],
      parent =parsedJson['parent'],
      kids =parsedJson['kids'],
      url =parsedJson['url'],
      score =parsedJson['score'],
      title =parsedJson['title'],
      descendants =parsedJson['descendants'];

// Armazena os dados vindo do banco de dados
  ItemModel.fromDb(Map<String, dynamic> parsedJson)
    : id =parsedJson['id'],
    // sql retorna 0 == false 1 == true
      deleted =parsedJson['deleted'] == 1,
      type =parsedJson['type'],
      by =parsedJson['by'],
      time =parsedJson['time'],
      text =parsedJson['text'],
    // sql retorna 0 == false 1 == // sql retorna 0 == false 1 == truerue
      dead =parsedJson['dead'] == 1,// sql retorna 0 == false 1 == true
      parent =parsedJson['parent'],// sql retorna 0 == false 1 == true
    // retorna um arquivo json com a lista de inteiros 
      kids =json.decode(parsedJson['kids']),
      url =parsedJson['url'],
      score =parsedJson['score'],
      title =parsedJson['title'],
      descendants =parsedJson['descendants'];

  // função que transforma o ItemModel em map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "type":type,
      "by":by,
      "time":time,
      "text": text,
      "parent":parent,
      "url": url,
      "score": score,
      "title":title,
      "descendants":descendants,
      "dead": dead ? 1 : 0,
      "deleted":deleted ? 1 : 0,
      "kids":jsonEncode(kids)
    };
  }

}