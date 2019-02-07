import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_online_aula/models/cart_model.dart';

class DiscountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
          title: Text("Cupom de Desconto", textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700]
            ),
          ),
          // icone do lado esquerdo
          leading: Icon(Icons.card_giftcard),
          // icone do lado direito
          trailing: Icon(Icons.add),
        // o conteúdo do ExpansionTile
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Digite seu Cupom"
              ),
              // se o couponCode for null apareça o texto vazio
              initialValue: CartModel.of(context).couponCode ?? "",
              onFieldSubmitted: (text) {
                // estamos procurando o cupom do texto digitado
                Firestore.instance.collection("coupons").document(text).get().then((docSnap){
                  if(docSnap.data != null) {
                    CartModel.of(context).setCoupon(text, docSnap.data["percent"]);
                    Scaffold.of(context).showSnackBar(
                      SnackBar(content:
                        Text("Desconto de ${docSnap.data["percent"]} % aplicado!",),
                        backgroundColor: Theme.of(context).primaryColor,
                      )
                    );
                  } else {
                    CartModel.of(context).setCoupon(null, 0);
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content:
                        Text("Esse cupom não existe. :("),
                          backgroundColor: Colors.redAccent,
                        )
                    );
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
