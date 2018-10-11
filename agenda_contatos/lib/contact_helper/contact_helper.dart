import 'package:sqflite/sqflite.dart';

// armazenando os nomes das colunas
final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String phoneColumn = "phoneColumn";
final String emailColumn = "emailColumn";
final String imgColumn = "imgColumn";

class ContactHelper {

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
  }
}