import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// armazenando os nomes das colunas
final String  contactTable = "contactTable";
final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String phoneColumn = "phoneColumn";
final String emailColumn = "emailColumn";
final String imgColumn = "imgColumn";

class ContactHelper {

  static final ContactHelper _instance = ContactHelper.internal();

  factory ContactHelper() => _instance;

  ContactHelper.internal();

  Database _db; // só essa classe poderá acessar o banco de dados

  get db async {
    if(_db != null)
      return _db;
    else {
      _db = await initDb();
      return _db;
    }
  }

  // função que inicializa o banco de dados
  Future<Database> initDb() async {
    final dataBasePath = await getDatabasesPath();
    final path = join(dataBasePath, "contacts.db"); // caminho do arquivo do banco de dados
    // retornamos db que é um Database
    openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
      return await db.execute(
        "CREATE TABLE $contactTable($imgColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $phoneColumn TEXT,"
            "$phoneColumn TEXT, $imgColumn TEXT)"
      );
    });
    return db;
  }

}

class Contact {

  int id;
  String name;
  String phone;
  String email;
  String img;

  Contact.fromMap(Map map) { // vai receber um map e atribuir os valores
    id = map[idColumn];
    name = map[nameColumn];
    phone = map[phoneColumn];
    email = map[emailColumn];
    img = map[imgColumn];
  }

  // coloca os dados do contato em um map
  Map toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      phoneColumn: phone,
      emailColumn: email,
      imgColumn: img
    };
    if(id != null) // o id será dado pelo banco de dados
      map[idColumn] = id;
  }

  @override
  String toString() {
    return ("Contact(id: $id, name: $name, phone: $phone, email: $email, img: $img)");
  }


}