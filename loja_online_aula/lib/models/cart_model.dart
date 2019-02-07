import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_online_aula/datas/cart_product_data.dart';
import 'package:loja_online_aula/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class CartModel extends Model {

  // podemos utilizar os dados do CartModel em qualquer lugar do app
  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  // estamos criando um UserModel para podermos ter acesso aos dados do usuário

  UserModel user;
  // Lista de produtos que será armazenada no carrinho
  List<CartProduct> products = [];
  // passaos no nosso construtor o usuario atual no app
  CartModel(this.user){
    // se o usuário estiver logado, iremos carregar os itens do carrinho
    if(user.isLoggedIn())
      _loadCartItems();

  }

  String couponCode; // cupom de desconto do usuário
  int discountPercentage = 0; // porcentagem do desconto

  bool isLoading = false;

  void addCartItem(CartProduct cartProduct) {

    products.add(cartProduct);    // adicionamos a lista de produtos do carrinho o produto atual

    Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("cart").add(cartProduct.toMap()).then((doc){
          // salvamos o id do produto para poder removê-lo depois
          cartProduct.cid = doc.documentID; // salvamos o ID do produto no carrinho
    });

    notifyListeners();
  }

  // Primeiro removemos do firebase o produto e depois removemos na lista de produtos

  void removeCartItem(CartProduct cartProduct) {
    Firestore.instance.collection("users").document(user.firebaseUser.uid).
    collection("cart").document(cartProduct.cid).delete();

    products.remove(cartProduct); // removemos da lista o produto

    notifyListeners();
  }

  void decProduct(CartProduct cartProduct){
    // decrementamos a quantidade do cartProduct (oou seja, o produto no carrinho) e
    // para depois atualizarmos passamos o novo documento, um map, para o Firebase atualizando
    // o banco de dados
    cartProduct.quantity--;
    Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("cart").document(cartProduct.cid).updateData(cartProduct.toMap());

    notifyListeners();
  }
  // mesmo processo só que agora incrementando
  void incProduct(CartProduct cartProduct){
    cartProduct.quantity++;
    Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("cart").document(cartProduct.cid).updateData(cartProduct.toMap());

    notifyListeners();
  }

  void _loadCartItems() async{
    // pegamos tod.os os documentos da coleção cart - ou seja, obtemos tod.os os produtos do carrinho
    QuerySnapshot querySnapshot = await Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("cart").getDocuments();

    // atribuimos a lista de produtos todos os documentos, ou seja, produtos, do firebase
    // transformamos em um mapa, depois fazemos uma lista de CartProducts
    products = querySnapshot.documents.map((doc) => CartProduct.fromDocument(doc)).toList();
  }

  // função que salva os dados do coupon no nosso CartModel
  void setCoupon(String couponCode, int discountPercentage) {
    // o this é usado para diferenciar as variáveis que são do nosso Model
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }

  double getProductsPrice() {
    double price = 0.0;
    // ou seja, para cada CartProduct c na lista de CartProduct iremos somar os preços
    for(CartProduct c in products){
      if(c.productData != null)
        price += c.quantity * c.productData.price;
    }
    return price;
  }

  double getDiscount() {
    // pegamos o preço de toda a compra e aplicamos o desconto
    return getProductsPrice() * discountPercentage / 100;
  }

  double getShipPrice() {
    return 9.99;
  }

  // função que atualiza os preços atualizando o listener
  void updatePrices(){
    notifyListeners();
  }
  // função que irá finalizar o pedido
  Future<String> finishOrder() async{
    // verificamos se há produtos no carrinho, senão, não irá haver compra
    if(products.length == 0) return null;

    isLoading = true;
    notifyListeners();

    double productsPrice = getProductsPrice();
    double discount = getDiscount();
    double shipPrice = getShipPrice();

    // estamos salvando o documetno e pegando a sua referencia para salvarmos seu ID
    DocumentReference docReference = await Firestore.instance.collection("orders").add(
      {
        "clientId": user.firebaseUser.uid,
        // estamos transformando cada cartProduct em products em em um mapa e fazendo uma lista
        "products": products.map((cartProducts) => cartProducts.toMap()).toList(),
        "shipPrice": shipPrice,
        "productsPrice": productsPrice,
        "discount": discount,
        "totalPrice": productsPrice - discount + shipPrice,
        "status": 1
      }
    );

    await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("orders")
      .document(docReference.documentID).setData(
      {
        "orderId": docReference.documentID
      }
    );

    // pegamos a lista de todos os documentos no carrinho
    QuerySnapshot query = await Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("cart").getDocuments();

    // para cada DocumentSnapshot doc na lista query de DocumentSnapshot iremos deletar
    for(DocumentSnapshot doc in query.documents) {
      doc.reference.delete();
    }

    // atualizamos todos os
    clearCartData();

    isLoading = false;
    notifyListeners();

    return docReference.documentID;

  }

  void clearCartData() {
    products.clear();
    couponCode = null;
    discountPercentage = 0;
  }

}