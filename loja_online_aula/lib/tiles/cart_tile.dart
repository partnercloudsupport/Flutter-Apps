import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_online_aula/datas/cart_product_data.dart';
import 'package:loja_online_aula/datas/product_data.dart';
import 'package:loja_online_aula/models/cart_model.dart';
import 'package:loja_online_aula/widgets/discount_card.dart';

/*
* Na CartTile é onde criamos os Tiles do carrinho.
* Carregamos as imagens e preços
*
* */

class CartTile extends StatelessWidget {

  CartProduct cartProduct;
  CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {

    Widget _buildContent() {

      // quando carregar os preços do CartTile, queremos atualizar também os preços
      // na CartPrice
      CartModel.of(context).updatePrices();

      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(4.0),
            width: 120.0,
            child: Image.network(cartProduct.productData.images[0],
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(cartProduct.productData.title, style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                  ),
                  Text("Tamanho: ${cartProduct.size}", style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w200,
                      color: Colors.black
                    ),
                  ),
                  Text("R\$ ${cartProduct.productData.price.toStringAsFixed(2)}", style:
                  TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    fontSize: 17.0
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton( // botão diminuir quantidade
                        icon: Icon(Icons.remove,
                          color: Theme.of(context).primaryColor,
                        ),
                        // se a quantidade for = 1, desabilitaremos o botão pois não queremos
                        // 0 produtos no carrinho.
                        onPressed: cartProduct.quantity > 1 ?
                          () {
                          CartModel.of(context).decProduct(cartProduct);
                        }
                          : null, // null no onPressed é igual a desabilitá-lo
                      ),
                      Text(cartProduct.quantity.toString()),
                      IconButton( // botão aumentar quantidade
                        icon: Icon(Icons.add,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: (){
                          CartModel.of(context).incProduct(cartProduct);
                        },
                      ),
                      FlatButton(
                        child: Text("Remover", style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black, fontWeight: FontWeight.w300
                          ),
                        ),
                        onPressed: (){
                          CartModel.of(context).removeCartItem(cartProduct);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      );

    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      // primeiro veremos se o produto já está armazenado no celular, se não estiveer, buscaremos
      // esses dados
      child: cartProduct.productData == null ?
        FutureBuilder<DocumentSnapshot>(
          future: Firestore.instance.collection("products").document(cartProduct.category)
              .collection("items").document(cartProduct.pid).get(),
          /*
          * Bug corrigido!!! No builder precisamos retornar o widget!!
          * */
          builder: (context, snapshot){
            // se ao buscar tinha dados, atribuir ao cartProduct.productData
            // transformamos o documento do firebase para um ProductData
            if(snapshot.hasData) {
              cartProduct.productData = ProductData.fromDocument(snapshot.data);
              return _buildContent();
            } else{
              return Container(
                height: 70.0,
                child: CircularProgressIndicator(),
                alignment: Alignment.center
              );
            }
          },
        )
          : _buildContent()
    );
  }
}
