import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_online_aula/tiles/places_tile.dart';

class PlacesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("places").getDocuments(),
      builder: (context, snapshot){
        if(!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );

        else
          // USamos a ListView para carregarmos os dados do firebase e com eles
          // fazermos a tela com o Widget PlacesTile
          return ListView(
            children: snapshot.data.documents.map((doc) => PlacesTile(doc)).toList(),
          );
      },
    );
  }
}
