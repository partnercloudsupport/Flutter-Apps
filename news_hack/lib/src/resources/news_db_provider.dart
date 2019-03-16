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
      onCreate: (Database newsDb, int version){

      }
    );
  }
}