import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_online_aula/datas/product_data.dart';
import 'package:loja_online_aula/tabs/products_tab.dart';
import 'package:loja_online_aula/tiles/product_tile.dart';

class CategoryScreen extends StatelessWidget {

  final DocumentSnapshot snapshot;

  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // quantidade de tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text(snapshot.data["title"]),
          centerTitle: true,
          bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: <Widget>[
                Tab(icon: Icon(Icons.grid_on),
                ),
                Tab(icon: Icon(Icons.list),)
              ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          // estamos obtendo os documentos da coleção items do documento products
          future: Firestore.instance.collection("products").document(snapshot.documentID).collection("items").getDocuments(),
          builder: (context, snapshot){
            if(!snapshot.hasData)
              return Center(child: CircularProgressIndicator(),);
            else{
              // O que queremos mostrar nas nossas Tabs
              return TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  GridView.builder(
                    padding: EdgeInsets.all(4.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      childAspectRatio: 0.65, // proporção da imagem largura por altura
                    ),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      // estamos transformando os dados do documento em um objeto do tipo ProductData
                      // e estamos passando para o ProductTile
                      ProductData data = ProductData.fromDocument(snapshot.data.documents[index]);
                      data.category = this.snapshot.documentID;

                      return ProductTile("grid", data);
                    },
                  ),
                  ListView.builder(
                    padding: EdgeInsets.all(4.0),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      // estamos transformando os dados do documento em um objeto do tipo ProductData
                      // e estamos passando para o ProductTile
                      ProductData data = ProductData.fromDocument(snapshot.data.documents[index]);
                      /*
                      * DÚVIDA!!! Porque usamos os this? Qual snapshot estamos usando??
                      * */
                      // estamos setando a categoria do produto e assim podemos usa-lá no carrinho
                      data.category = this.snapshot.documentID;

                      return ProductTile("list", data);
                    },
                  )
                ]
              );
            }
        }),
      ),
    );
  }
}
