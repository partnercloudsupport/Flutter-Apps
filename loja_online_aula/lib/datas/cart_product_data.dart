

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_online_aula/datas/product_data.dart';

class CartProduct {

  CartProduct();

  String cid; // cid = card id

  String category; // salvar a categoria do produto
  String pid; // product id

  int quantity; // quantidade de produtos que o usuário irá defininr
  String size; // o tamanho também não irá alterar-se

  // como queremos os dados dos produtos para usá-los no carrinho:

  ProductData productData;

  // vamos passar os dados do banco de dados para o carrinho
  CartProduct.fromDocument(DocumentSnapshot document) {
    cid = document.documentID;
    category = document.data["category"];
    pid = document.data["pid"];
    quantity = document.data["quantity"];
    size = document.data["size"];
  }

  // 
  Map<String, dynamic> toMap(){
    return {
      "category" : category,
      "pid" : pid,
      "quantity" : quantity,
      "size" : size,
      "product" : productData.toResumedMap()
    };
  }
}