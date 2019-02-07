import 'package:flutter/material.dart';
import 'package:loja_online_aula/models/cart_model.dart';
import 'package:loja_online_aula/models/user_model.dart';
import 'package:loja_online_aula/screens/login_screen.dart';
import 'package:loja_online_aula/screens/order_screen.dart';
import 'package:loja_online_aula/tiles/cart_tile.dart';
import 'package:loja_online_aula/widgets/cart_price.dart';
import 'package:loja_online_aula/widgets/discount_card.dart';
import 'package:loja_online_aula/widgets/ship_card.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Carrinho"),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 8.0),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(builder: (context, child, model){
              int p = model.products.length;
            // notação variavel ?? algo = se a variável for nula fazemos algo
            // Se não tiver produtos no carrinho simplesmente aparecerá 0
            // se tiver apenas 1 item será ITEM e se tiver mais será ITENS
              return Text("${p ?? 0} ${p == 1 ? "ITEM" : "ITENS"}",
                style: TextStyle(
                  fontSize: 16.0
                ),);
            }),
          ),
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
          builder: (context, child, model){
        // temos os casos:
        // 1 - Se está carregando algum pedido e o usuário está logado
        // 2 - Se o usuário não está logado
        // 3 - Se não tiver nenhum produto no carrinho ou for nula
        if(model.isLoading && UserModel.of(context).isLoggedIn()){
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if(! UserModel.of(context).isLoggedIn()){
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.remove_shopping_cart, size: 80.0, color: Theme.of(context).primaryColor,),
                SizedBox(height: 16.0),
                Text("Faça o login para adicionar seus produtos!", style:
                  TextStyle(
                    fontSize: 17.0,
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
        } else if(model.products == null || model.products.length == 0){
          return Center(
            child: Text(
              "Nenhum produto no Carrinho",
              style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return ListView(
            // Estamos carregando os Widgets por programação, carregando através do map
            children: <Widget>[
              Column(
                children: model.products.map((product){
                  return CartTile(product);
                }).toList(),
              ),
              DiscountCard(),
              ShipCard(),
              CartPrice(() async {
                // finishOrder retorna o ID do pedido
                String orderId = await model.finishOrder();
                if(orderId != null)
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => OrderScreen(orderId))
                  );
              }),
            ],
          );
        }
      }),
    );
  }
}
