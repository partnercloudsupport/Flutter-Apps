// notação para mostrarmos apenas a classe Client
import 'package:http/http.dart' show Client; 
import 'dart:convert';
import 'package:news_hack/src/models/item_model.dart';

class NewsApiProvider{
  final _root = 'https://hacker-news.firebaseio.com/v0';

  Client client =Client();

  // Obtem os Ids dos tops items
  Future<List<int>> fetchTopIds() async {
    // recebe a resposta
    final response = await client.get('$_root/topstories.json');
    // Ids dos top items
    final ids = json.decode(response.body); // convertemos para um mapa
    // retorna os Ids dos top items
    // we use the cast<R> function because dart doesn't know
    // what type is returned from json.decode
    return ids.cast<int>();
  }
  // armazenamos os dados do item selecionado pelo ID no ItemModel
  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get('$_root/item/8863.json');
    // transformamos em um json
    final parsedJson = json.decode(response.body);
    // armazenamos os dados do json no ItemModel
    return ItemModel.fromJson(parsedJson);
  }
}