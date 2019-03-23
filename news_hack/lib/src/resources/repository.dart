// Classe que fará a intermediação dos providers de modo
// que nosso app não precise utilizar a lógica direntamente
// dos providers, simplificando e tendo melhor controle
// de quando usar os dois providers

import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class Repository {
  // instancia ps providers
  NewsDbProvider dbProvider =NewsDbProvider();
  NewsApiProvider apiProvider =NewsApiProvider();

  // Returns top Ids
  Future<List<int>> fetchTopIds() {
    return apiProvider.fetchTopIds();
  }

  // Returns a ItemModel
  Future<ItemModel> fetchItem(int id) async {
    // Search first in DB
    var item = await dbProvider.fetchItem(id);
    // Verify if there is a Item in the DB
    if(item != null)
      return item;
    
    // If not, use apoProvider to provide the Item
    item = await apiProvider.fetchItem(id);
    // put the item in DB for the case of need then
    // It Don't used await because we don't need to await
    // to put it in the Db. We just want to returns a Item to fetchItem 
    dbProvider.addItem(item);
    // returns a item
    return item;
  }
}

// Interface of the two functions of API provider and DB provider
abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

// Interface of the functions that store data in the repository
abstract class Cache {
  Future<int> addItem(ItemModel item);
}