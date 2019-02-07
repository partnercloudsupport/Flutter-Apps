import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_online_aula/screens/category_screen.dart';

class CategoryTile extends StatelessWidget {

  final DocumentSnapshot snapshot;

  CategoryTile(this.snapshot); // estamos passando o documento para

  @override
  Widget build(BuildContext context) {
    return ListTile( //usamos para lidar com listas
      leading: CircleAvatar( // icone que fica a esquerda
        radius: 25.0,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(snapshot.data["icon"]),
      ),
      trailing: Icon(Icons.keyboard_arrow_right), // icone que fica a direita
      title: Text(snapshot.data["title"]),
      onTap: (){
        // estamos trocando de tela
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => CategoryScreen(snapshot))
        );
      },
    );
  }
}
