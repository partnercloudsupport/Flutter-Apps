import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_online_aula/models/user_model.dart';
import 'package:loja_online_aula/screens/login_screen.dart';
import 'package:loja_online_aula/tiles/order_tile.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    if(UserModel.of(context).isLoggedIn()){

      String uid = UserModel.of(context).firebaseUser.uid;

      return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("users").document(uid).collection("orders").getDocuments(),
        builder: (context, snapshot){
          if(!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );

          else {
            return ListView(
              // estamos passando os ID's dos pedidos para a OrderTile onde ela irá acessar
              // os dados dos pedidos no firebase
              children: snapshot.data.documents.map((doc) => OrderTile(doc.documentID)).toList().reversed.toList(),
            );
          }
        },
      );

    } else { // se o usuário não está logado, pediremos para logar
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.view_list, size: 80.0, color: Theme.of(context).primaryColor,),
            SizedBox(height: 16.0),
            Text("Faça o login para visualizar seus pedidos!", style:
            TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            SizedBox(height: 44.0,
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text("Entrar", style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.white
                  ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen())
                    );
                  },
                )
            )
          ],
        ),
      );
    }
  }
}
