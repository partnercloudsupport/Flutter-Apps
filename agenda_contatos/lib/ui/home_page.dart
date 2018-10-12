import 'package:agenda_contatos/contact_helper/contact_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override

  ContactHelper helper = ContactHelper();

  List<Contact> contacts = List();

  @override
    void initState() {
      super.initState();

      helper.getAllContacts().then((list){
        setState(() {
          contacts = list;       
        });  
      }); 
    }

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
          print(contacts.length);
        }
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: contacts.length,
        // função que irá criar a lista de widgets que queremos criar
        itemBuilder: (context, index) {
          
        },
      ),
    );
  }
}
