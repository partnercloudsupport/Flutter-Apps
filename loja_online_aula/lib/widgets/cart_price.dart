import 'package:flutter/material.dart';
import 'package:loja_online_aula/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';
class CartPrice extends StatelessWidget {

  // vamos passar a função da tela CartScreen e chama-lá aqui

  final VoidCallback buy;

  CartPrice(this.buy);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: ScopedModelDescendant<CartModel>(
          builder: (context, child, model){

            double price = model.getProductsPrice();
            double discount = model.getDiscount();
            double ship = model.getShipPrice();
            double total = price + ship - discount;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text("Resumo do pedido", style: TextStyle(
                  fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 12.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Subtotal:"),
                    Text("R\$ ${price.toStringAsFixed(2)}")
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Desconto:"),
                    Text("R\$ ${discount.toStringAsFixed(2)}")
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Entrega:"),
                    Text("R\$ ${ship.toStringAsFixed(2)}")
                  ],
                ),
                Divider(),
                SizedBox(height: 12.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Total:", style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),),
                    Text("R\$ ${total.toStringAsFixed(2)}", style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.0
                      ),
                    ),
                    SizedBox(height: 12.0,),
                    RaisedButton(
                      child: Text("Confirmar Pedido"),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: buy,
                    )
                  ],
                ),
              ],
            );
        })
      ),
    );
  }
}
