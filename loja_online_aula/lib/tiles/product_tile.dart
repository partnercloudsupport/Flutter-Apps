import 'package:flutter/material.dart';
import 'package:loja_online_aula/datas/product_data.dart';
import 'package:loja_online_aula/screens/product_screen.dart';

class ProductTile extends StatelessWidget {

  ProductData product;
  String type;

  ProductTile(this.type, this.product);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              // Trocamos de tela para a tela do produto passando o produto atual
              MaterialPageRoute(builder: (context)=>ProductScreen(product)
              )
            );
          },
          child: Card(
            child: type == "grid" ?
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, // porque está esticando a imagem // duvida
                mainAxisAlignment: MainAxisAlignment.start,
                // como não queremos que a imagem varie de dispositivo pra dispositivo, colocamos o AspecRatio
                // pra regularmos a proporção largura / altura
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 0.8,
                    child: Image.network(
                      product.images[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(product.title, style:
                            TextStyle(
                              fontWeight: FontWeight.w500,
                            )
                          ), // preço
                          Text("R\$ ${product.price.toStringAsFixed(2)}", style:
                          TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0
                          ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
              // Estamos usando o Flexible pois queremos a mesma proporção da imagem
            // em todos os dispositivos. Para isso, a proporção é dada de Flexible para Flexible
              : Row(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: AspectRatio(
                    aspectRatio: 0.8,
                    child: Image.network(
                      product.images[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(product.title, style:
                        TextStyle(
                          fontWeight: FontWeight.w500,
                        )
                        ), // preço
                        Text("R\$ ${product.price.toStringAsFixed(2)}", style:
                        TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0
                        ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}
