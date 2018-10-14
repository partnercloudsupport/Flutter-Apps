import 'package:agenda_contatos/contact_helper/contact_helper.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'contact_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override

  @override
  void initState() {
    super.initState();
    
    contact.name = "thiago";
    contact.email = "tsc0877@gmail.com";
    contact.phone = "88988722564";
    //contact.img = "imgTest";

    helper.saveContact(contact);
    _getAllContacts();
  }

  ContactHelper helper = ContactHelper();
  Contact contact = Contact();
  List<Contact> contacts = List(); // lista de contatos  contact

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Contatos"),
      backgroundColor: Colors.blueAccent,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          _showContactPage();
        }
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: contacts.length,
        // função que irá criar a lista de widgets que queremos criar
        itemBuilder: (context, index) {
          return _contactCard(context, index);
        },
      ),
    );
  }

  Widget _contactCard(BuildContext context, int index) {
    return GestureDetector( 
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget> [
              Container(
                height: 80.0,
                width: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    // caso a imagem do contato não seja null, ?, pegaremos o arquivo de imagem
                    // caso seja null, : , usamos uma imagem padrão
                    image: contacts[index].img != null ?
                      FileImage(File(contacts[index].img)) :
                        AssetImage("images/contact_image.png")
                  )
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // o ?? "" significa: se for nulo, atribuir "" (um texto vazio) 
                    // para não dar erro
                    Text(contacts[index].name ?? "", 
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                      ),
                      Text(contacts[index].email ?? "", 
                      style: TextStyle( fontSize: 18.0),
                      ),
                      Text(contacts[index].phone ?? "", 
                      style: TextStyle( fontSize: 18.0),
                      )
                  ],
                ),
              )
            ]
          ),
        )
      ),
      onTap: () {
        _showContactPage(contact: contacts[index]);
      },
    );
  }
  
  // função que chamará a tela de contatos
  // o parâmetro é opcional
  void _showContactPage({Contact contact}) async {
    final recContact = await Navigator.push(context, 
      MaterialPageRoute(builder: (context) => ContactPage(contact: contact,)
      )
    );
    if(recContact != null){
      if(contact != null){ // ou seja, o contato já existe e vamos atualiza-lo
        helper.updateContact(contact);
      } else { // ou seja, estamos criando um contato
        helper.saveContact(contact);
      } 
      _getAllContacts();
    }
  }

// função que atualiza todos os contatos
void _getAllContacts() {
  helper.getAllContacts().then((list){
      setState(() {
        contacts = list;
      });
  });
}

}
