import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {

  String category;
  String id;

  String title;
  String descripion;
  double price;

  List images;
  List sizes;


  // construtor que passará os dados do documento para um objeto ProductData
  // Orientação a objetos!!!!

  ProductData.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.documentID;
    title = snapshot.data["title"];
    descripion = snapshot.data["description"];
    price = snapshot.data["price"];
    images = snapshot.data["images"];
    sizes = snapshot.data["sizes"];
  }

  // salvamos um resumo para que os dados do produto feito na compra não mude conforme
  // pois será as informações de compra do usuário

  Map<String, dynamic> toResumedMap() {
    return
    {
      "title": title,
      "description": descripion,
      "price":price
    };
  }

}