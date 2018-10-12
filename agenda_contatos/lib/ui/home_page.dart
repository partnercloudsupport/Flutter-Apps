import 'package:agenda_contatos/contact_helper/contact_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override

  ContactHelper helper = ContactHelper();


  @override
  void initState() {
    super.initState();

    Contact contact = Contact(); // criamos um objeto contato

    contact.name = "Thiago Souza de Carvalho";
    contact.phone = "391833";
    contact.email = "thiago@gmail.com";
    contact.img = "imgtest";

    helper.saveContact(contact); // salvamos o contato passando os dados para o banco de dados
    helper.getAllContacts().then((list){
      print(list);
    });
  }

  Widget build(BuildContext context) {
    return Container();
  }
}
