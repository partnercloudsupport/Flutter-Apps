// notação para mostrarmos apenas a classe Client
import 'package:http/http.dart' show Client; 
import 'dart:convert';
import 'package:news_hack/src/models/item_model.dart';

class NewsApiProvider{
  final _root = 'https://hacker-news.firebaseio.com/v0';

  Client client =Client();

  // Obtem os Ids dos tops items
  fetchTopIds() async {
    // recebe a resposta
    final response = await client.get('$_root/topstories.json');
    // Ids dos top items
    final ids = json.decode(response.body); // convertemos para um mapa
    // retorna os Ids dos top items
    return ids; 
  }
  // armazenamos os dados do item selecionado pelo ID no ItemModel
  fetchItem(int id) async {
    final response = await client.get('$_root/item/8863.json');
    // transformamos em um json
    final parsedJson = json.decode(response.body);
    // armazenamos os dados do json no ItemModel
    return ItemModel.fromJson(parsedJson);
  }
}