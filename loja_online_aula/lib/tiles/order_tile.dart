import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {

  final String orderId;

  OrderTile(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Padding(
          padding: EdgeInsets.all(8.0),
          // estamos usando o stream builder pois quremos atualizações da tela em tempo real
          child: StreamBuilder<DocumentSnapshot>(
            // estamos usando o .snapshots pois ele que fará o stream, ou seja,
            // irá ficar verificando toda hora se algo atualizou
            // ele está verificando os pedidos
              stream: Firestore.instance.collection("orders").document(orderId).snapshots(),
              builder: (context, snapshot){

                if(!snapshot.hasData)
                  return Center(child: CircularProgressIndicator(),);

                else{
                // lembrar de usar o snapshot só após confirmar que há dados!!
                  int status = snapshot.data["status"];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // pegamos o ID do documento atual do snapshot, ou seja, o pedido atual
                      Text("Código do pedido: ${snapshot.data.documentID}", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0
                        ),
                      ),
                      SizedBox(height: 4.0,),
                      Text(
                          _buildProductsText(snapshot.data),
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(height: 4.0,),
                      Text("Status do pedido:", style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0
                        )
                      ),
                      SizedBox(height: 4.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                        _buildCircle("1", "Preparação", status, 1),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.0),
                          height: 1.0,
                          width: 40.0,
                          color: Colors.grey,
                        ),
                        _buildCircle("2", "Transporte", status, 2),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.0),
                          height: 1.0,
                          width: 40.0,
                          color: Colors.grey,
                        ),
                        _buildCircle("3", "Finalizado", status, 3),
                      ],
                      )
                    ],
                  );
                }

              }),
      ),
    );
  }

  // usamos a

  String _buildProductsText(DocumentSnapshot snapshot){
    String text = "Descrição\n";
    // Usamos a LinkedHashMap pois a lista que estamos obtendo os dados no firebase é do
    // tipo LinkedHashMap (Dúvida de o que é uma LinkedHashMap!!)
    // essa lista é a lista dos dados dos produtos salvos na coleção orders
    for(LinkedHashMap p in snapshot.data["products"]){
      text += "${p["quantity"]} x ${p["product"]["title"]} R\$${p["product"]["price"].toStringAsFixed(2)}\n";
    }

    text += "Total: ${snapshot.data["totalPrice"].toStringAsFixed(2)}";

    return text;
  }

  // Widget que fará a "bolinha" do status do pedido do cliente

  Widget _buildCircle(String title, String subtitle, int status, int thisStatus) {

    Color backColor;
    Widget child;

    // Primeiro caso: Onde o estado atual é menor do que a da bolinha, ou seja, não chegamos
    // nesse estado
    if(status < thisStatus) {
      backColor = Colors.grey[500];
      child = Text(title, style: TextStyle(color: Colors.white),);
      // caso onde o estado atual do pedido é igual ao estado atual da bolinha
    } else if(status == thisStatus) {
      backColor = Colors.blue;
      child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(title, style: TextStyle(color: Colors.white),),
          CircularProgressIndicator(
            // faz a animação do CircularProgressIndicator
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      );
    } else {
      backColor = Colors.green;
      child = Icon(Icons.check, color: Colors.white,);
    }

    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          child: child,
          backgroundColor: backColor,
        ),
        Text(subtitle, style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w400
          ),
        )
      ],
    );
  }

}
