import 'package:agenda_contatos/contact_helper/contact_helper.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'contact_page.dart';
import 'package:url_launcher/url_launcher.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override

  @override
  void initState() {
    super.initState();

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
      actions: <Widget>[
             PopupMenuButton<OrderOptions>(
               itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
                const PopupMenuItem<OrderOptions>(
                  child: Text("Ordenar A-Z"),
                  value: OrderOptions.orderaz,
                  ),
                  const PopupMenuItem<OrderOptions>(
                  child: Text("Ordenar Z-A"),
                  value: OrderOptions.orderza,
                  ),
               ],
               onSelected: _orderList,
             )
           ],
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
        //_showContactPage(contact: contacts[index]);
        _showOptions(context, index); 
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
        helper.updateContact(recContact);
      } else { // ou seja, estamos criando um contato
        helper.saveContact(recContact);
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

void _showOptions(BuildContext context, int index) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: FlatButton(
                    onPressed: () {
                      launch("tel: ${contacts[index].phone}");
                      Navigator.pop(context);
                    },
                    child: Text("Ligar", 
                      style: TextStyle(fontSize: 18.0, color: Colors.blueAccent),
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _showContactPage(contact: contacts[index]);
                    },
                    child: Text("Editar", 
                       style: TextStyle(fontSize: 18.0, color: Colors.blueAccent)
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: FlatButton(
                    onPressed: () {
                      helper.deleteContact(contacts[index].id);
                      setState(() {
                        contacts.removeAt(index);
                        Navigator.pop(context);                    
                      });
                    },
                    child: Text("Excluir", 
                       style: TextStyle(fontSize: 18.0, color: Colors.blueAccent)
                    )
                  ),
                ),
              ],
            ),
          ); 
        },
      );
    }
  );
}

void _orderList(OrderOptions result) {
    switch(result) {
      case OrderOptions.orderaz:
        contacts.sort((a, b){
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
      break;
      case OrderOptions.orderza:
        contacts.sort((a,b){
          return b.name.toLowerCase().compareTo(a.name.toLowerCase());
        });
      break;
    }
    setState(() {
          
    });
  }

}
