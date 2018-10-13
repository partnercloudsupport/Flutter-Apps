import 'package:flutter/material.dart';
import 'package:agenda_contatos/contact_helper/contact_helper.dart';

class ContactPage extends StatefulWidget {

  final Contact contact;
  ContactPage({this.contact}); // o parametro é opcional pois iremos editar o contato ou criar um novo
  
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  
  Contact _editedContact;

  @override
  void initState() {
    super.initState();
    if(widget.contact == null) { // se não passamos nenhum contato, criamos um novo
      _editedContact = Contact();
    } else {
      // passamos os dados de um contato para o _editedContact
      // pegamos o map e fazemos um novo contato através desse mapa
      _editedContact = Contact.fromMap(widget.contact.toMap());
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         appBar: AppBar(
           centerTitle: true,
           backgroundColor: Colors.blueAccent,
           title: Text(_editedContact.name ?? "Novo Contato"),
         ),
         floatingActionButton: FloatingActionButton(
          onPressed: (){},
          child: Icon(Icons.save,),
          backgroundColor: Colors.blueAccent,
         ),
       ),
    );
  }
}