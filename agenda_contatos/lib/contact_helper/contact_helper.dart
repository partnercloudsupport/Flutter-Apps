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
  // retorna uma instância do objeto
  factory ContactHelper() => _instance;
  ContactHelper.internal();

  Database _db; // só essa classe poderá acessar o banco de dados

  Future<Database> get db async {
    if(_db != null) // se o db já foi inicializado
      return _db;
    else {
      _db = await initDb();
      return _db;
    }
  }

  // função que inicializa o banco de dados
  Future<Database> initDb() async {
    final dataBasePath = await getDatabasesPath();
    final path = join(dataBasePath, "contacts1.db"); // caminho do arquivo do banco de dados
    // retornamos db que é um Database
    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
        await db.execute(
        "CREATE TABLE $contactTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $emailColumn TEXT,"
            " $phoneColumn TEXT, $imgColumn TEXT)"
      );
    }); 
  }

  Future<Contact> saveContact(Contact contact) async {
    Database dbContact = await db; // obter o banco de dados usando o get db
    contact.id = await dbContact.insert(contactTable, contact.toMap()); // retorna o id da insersão
    return contact;
  }

  // O where e whereArgs são as condições para retornar as colunas
  // o where "$idColum = ?" significa que o argumento ? é o parâmetro passado no whereArgs, no caso o  [id]
  Future<Contact> getContact(int id) async {
    Database dbContact = await db; // obter o banco de dados usando o get db
    List<Map> maps = await dbContact.query(contactTable,
      columns: [idColumn, nameColumn, emailColumn, phoneColumn, imgColumn],
      where: "$idColumn = ?",
      whereArgs: [id]
    );
    if(maps.length > 0){ // se há elementos no maps
      // retornamos o primeiro map encontrado, ou seja, que atendeu aos argumentos do where e whereArgs
      return Contact.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // excluiremos o contato com o id passado.
  // usamos o where e whereArgs para remover o contactTable correto
  Future<int> deleteContact(int id) async {
    Database dbContact = await db;
    return await dbContact.delete(contactTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  // função que atualiza o contato
  Future<int>updateContact(Contact contact) async {
    Database dbContact = await db;
    return await dbContact.update(contactTable, contact.toMap(),
        where: "$idColumn",
        whereArgs: [contact.id]);
  }

  Future<List>getAllContacts() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $contactTable"); // lista de maps
    List<Contact> listContacts = List(); // lista de contatos
    for(Map m in listMap){ // para cada m na lista listMap... adicionar ao lista de contatos
      listContacts.add(Contact.fromMap(m)); // passamos o map e atribuimos os valores
    }
    return listContacts;
  }

  // Função que fecha o banco de dados
  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }

}

class Contact {

  Contact();

  int id;
  String name;
  String phone;
  String email;
  String img;

  Contact.fromMap(Map map) { // vai receber um map e atribuir os valores
    id = map[idColumn];
    email = map[emailColumn];
    name = map[nameColumn];
    phone = map[phoneColumn];
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

    return map;
  }

  @override
  String toString() {
    return ("Contact(id: $id, name: $name, phone: $phone, email: $email, img: $img)");
  }
}