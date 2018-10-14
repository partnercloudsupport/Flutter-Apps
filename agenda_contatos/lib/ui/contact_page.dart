import 'package:flutter/material.dart';
import 'package:agenda_contatos/contact_helper/contact_helper.dart';
import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';

// enum é um conjunto de valores constantes
enum OrderOptions {orderaz, orderza}

class ContactPage extends StatefulWidget {

  final Contact contact;
  ContactPage({this.contact}); // o parametro é opcional pois iremos editar o contato ou criar um novo
  
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  final _nameFocus = FocusNode();
  
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
      // se não for um contato vazio, atualizar os controladores
      _nameController.text = _editedContact.name;
      _emailController.text = _editedContact.email;
      _phoneController.text = _editedContact.phone;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
           centerTitle: true,
           backgroundColor: Colors.blueAccent,
           title: Text(_editedContact.name ?? "Novo Contato"),
        ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              if(_editedContact.name != null && _editedContact.name.isNotEmpty){
                Navigator.pop(context, _editedContact);
              } else{
                FocusScope.of(context).requestFocus(_nameFocus);
              }
            },
            child: Icon(Icons.save,
            ),
          backgroundColor: Colors.blueAccent,
          ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(children: <Widget>[
            GestureDetector(
              onTap: () {
                ImagePicker.pickImage(source: ImageSource.camera).then((file){
                  if(file == null) return;
                  setState(() {
                    _editedContact.img = file.path;                
                  });
                });
              },
              child: Container(
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
            ),
              TextField(
                controller: _nameController,
                focusNode: _nameFocus,
                decoration: InputDecoration(
                  labelText: "Nome"),
                  onChanged: (text) {
                    setState(() {
                      _editedContact.name = text; // atualiza o contato com o texto do TextField 
                    });
                  },
              ),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email"),
                  onChanged: (text) {
                    _userEdited = true; // indica que o contato foi editado
                    _editedContact.email = text; // atualiza o contato com o texto do TextField 
                  },
              ),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Phone"),
                  onChanged: (text) {
                    _userEdited = true; // indica que o contato foi editado
                    _editedContact.phone = text; // atualiza o contato com o texto do TextField 
                  },
              ),
            ],
          )
        ),
      )
    );
  }

  // função que será chamada ao apertar o botão de voltar 
  Future<bool>_requestPop() {
    if(_userEdited){
      showDialog(
        context: context, 
        builder: (context){
          return AlertDialog(
            title: Text("Descartar alterações?"),
            content: Text("Se sair as alterações serão perdidas."),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancelar"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("Sim"),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
        return Future.value(false); // não permite sair automaticamente da tela
    } else {
        return Future.value(true); // permite sair automaticamente da tela
    }
    
  }
}