import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_online_aula/tiles/category_tile.dart';

class ProductsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("products").getDocuments(), // esperamos o futuro do documento
      builder: (context, snapshot) {
        if(!snapshot.hasData)
          return Center(child: CircularProgressIndicator(),);
        else{

          // Estamos criando um ListTile, usando o comando divideTiles para separar as tiles
          // estamos pegando as tiles do documento
          // transformando em lista com a lista de tiles separadas
          // meio confuso!!

          var dividedTiles = ListTile.divideTiles(
              tiles: snapshot.data.documents.map(
                      (doc) {
                    return CategoryTile(doc);
                  }
              ).toList(),
            color: Colors.grey[500]
          ).toList();
          return ListView( // o que estamos fazendo é: pegando o mapa transformando em um CategoryTile e depois
                          //  em uma lista
            children: dividedTiles
          );
        }
      },
    );
  }
}