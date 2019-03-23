import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';
import 'repository.dart';

class NewsDbProvider implements Source, Cache{
  // Variable that is the connection with our database
  Database db; 

  // We create this function to no have problem with abstract class
  // source, it's only for a example

  Future<List<int>> fetchTopIds() {
    return null;
  }

  // Cria e inicia o banco de dados
  void init() async {
    // Obtém a o diretório de onde podemos acessar os documentos
    // de forma segura do nosso App
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    
    // Salvamos o diretório do arquivo que será guardado o database
    // no diretório do app (documentsDirectory/items.db),
    // string obtida do join
    final path = join(documentsDirectory.path, 'items.db');

    // criamos o documento
    db = await openDatabase(// funçao que inicia (se não existe) ou cria o bando de dados
      path,
      version: 1,
      // usamos o newsDb pois ainda não iniciamos a variavel db
      // newsDb é apenas uma conexão com o banco de dados
      onCreate: (Database newsDb, int version){
        // String multi-line usamos """ multi-line """
        newsDb.execute("""
          CREATE TABLE Items
          (
            id INTEGER PRIMARY KEY,
            type TEXT,
            by TEXT,
            time INTEGER,
            parent INTEGER,
            kids BLOB, 
            dead INTEGER,
            delete INTEGER,
            url TEXT,
            score INTEGER,
            title TEXT,
            descendants INTEGER
          )
        """);
      }
    );
  }

  // Obtem um item do banco de dados
  Future<ItemModel> fetchItem(int id) async {
    // obtemos os dados da table items
    // da row ID = id
    // todas as colunas
    // retorna Future<List<Map<String, dynamic>>>
    final maps = await db.query(
      'items',
      columns: null, // não especificamos qual coluna queremos, obtemos todas
      where: "id = ?", // qual linha queremos obter os dados
      whereArgs: [id]
    );
    // verifica se o documento existe 
    if(maps.length > 0) {
      // usamos maps.first pois só queremos o primeiro map da lista
      // pois só terá os casos: 1 map (o que queremos)
      // 0 maps (não há documentos)
      return ItemModel.fromDb(maps.first);
    }
    // se não houver nenhum documento, retornamos null especificando
    // que não há nenhum documento com esse ID
    return null;

  }

  // Adiciona 1 item (ItemModel) no banco de dados 
  Future<int> addItem(ItemModel item) {
    // passamos a table do nosso banco de dados
    // passamos um map que tem os dados pra serem adicionados no banco de dados
    return db.insert("items", item.toMap());
  }

}