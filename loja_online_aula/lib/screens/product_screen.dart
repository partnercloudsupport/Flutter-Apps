import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_online_aula/datas/cart_product_data.dart';
import 'package:loja_online_aula/datas/product_data.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:loja_online_aula/models/cart_model.dart';
import 'package:loja_online_aula/models/user_model.dart';
import 'package:loja_online_aula/screens/cart_screen.dart';
import 'package:loja_online_aula/screens/login_screen.dart';

class ProductScreen extends StatefulWidget {

  final ProductData product;

  ProductScreen(this.product);
  // estamos passando o produto atual pra State, com isso evitamos digitar widget.produ

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {

  final ProductData product;

  String size; // tamanho do produto

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              // passamos o map, ou seja, todos as urls do firebase para um NetworkImage, criando a imagem,
              // e salvando numa lista
              images: product.images.map((url){
                return NetworkImage(url);
              }).toList(),
              // dot é o ponto na imagem
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(product.title, style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500
                  ),
                ),
                Text("R\$ ${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: primaryColor
                  ),
                ),
                SizedBox(height: 16.0), // espaçamento
                Text("Tamanho", style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5 // largura o dobro da altura
                    ),
                    // estamos criando uma lista de Widgets que serão carregados com os dados
                    // dos tamanhos no firebase, retornando uma lista e retornando
                    // pros children do GridView
                    children: product.sizes.map(
                      (stringSizes){
                        return GestureDetector(
                          onTap: () {
                            // armazenamos na variavel size o tamanho escolhido pelo usuario
                            setState(() {
                              size = stringSizes;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.0),),
                              border: Border.all(
                                // se o icone do tamanho é o clickado pelo usuario, colocaremos a cor primaria
                                color: size == stringSizes ? primaryColor : Colors.grey[500],
                                width: 3.0
                              ),
                            ),
                            width: 50.0,
                            alignment: Alignment.center,
                            child: Text(stringSizes),
                          ),
                        );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 16.0,),
                SizedBox(height: 44.0,
                  child: RaisedButton(
                    color: primaryColor,
                    // se o usuário estiver logado, mostraremos o texto:
                    child: Text(UserModel.of(context).isLoggedIn() ? "Adicionar ao Carrinho"
                    // se não estiver:
                      : "Entre para Comprar" , style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white
                      ),
                    ),
                    // se for escolhido algum tamanho, habilitamos o botao, senao, deixamos desabilitado
                    onPressed: size != null ?
                      (){
                        if(UserModel.of(context).isLoggedIn()){

                          CartProduct cartProduct = CartProduct();
                          cartProduct.size = size;
                          cartProduct.quantity = 1;
                          cartProduct.pid = product.id;
                          cartProduct.category = product.category;
                          cartProduct.productData = product;

                          // para chamarmos a função no model sem usar o ScopedModel
                          CartModel.of(context).addCartItem(cartProduct);
                        // ao adicionar ao carrinho o produto, iremos para a tela do carrinho
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => CartScreen())
                          );

                        } else{ // caso não esteja logado, iremos ir para a tela de Login
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => LoginScreen())
                          );
                        }
                      }
                    : null,
                  ),
                ),
                SizedBox(height: 16.0,),
                Text("Descrição", style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0
                  ),
                ),
                Text(product.descripion, style: TextStyle(
                    fontSize: 16.0
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
