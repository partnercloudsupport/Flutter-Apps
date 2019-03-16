import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';

class NewsDbProvider {
  // Variable that is the connection with our database
  Database db; 

  // Cria e inicia o banco de dados
  init () async {
    // Obtém a o diretório de onde podemos acessar os documentos
    // de forma segura do nosso App
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    
    // Salvamos o diretório do arquivo que será guardado o database
    // no diretório do app (documentsDirectory/items.db),
    // string obtida do join
    final path = join(documentsDirectory.path, 'items.db');

    
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
}