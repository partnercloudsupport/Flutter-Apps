import 'package:flutter/material.dart';
import 'package:agenda_contatos/contact_helper/contact_helper.dart';
import 'dart:io';

class ContactPage extends StatefulWidget {

  final Contact contact;
  ContactPage({this.contact}); // o parametro é opcional pois iremos editar o contato ou criar um novo
  
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  
  bool _userEdited = false;  // indica se o usuário editou o contato

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
    return Scaffold(
        appBar: AppBar(
           centerTitle: true,
           backgroundColor: Colors.blueAccent,
           title: Text(_editedContact.name ?? "Novo Contato"),
        ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){},
            child: Icon(Icons.save,
            ),
          backgroundColor: Colors.blueAccent,
          ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(children: <Widget>[
              Container(
                height: 140.0,
                width: 140.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    // caso a imagem do contato não seja null, ?, pegaremos o arquivo de imagem
                    // caso seja null, : , usamos uma imagem padrão
                    image: _editedContact.img != null ?
                      FileImage(File(_editedContact.img)) :
                        AssetImage("images/contact_image.png")
                  )
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Nome"),
                  onChanged: (text) {
                    _userEdited = true;
                    setState(() {
                      _editedContact.name = text;
                    });
                  },
              )
            ],
          )
        ),
    );
  }
}