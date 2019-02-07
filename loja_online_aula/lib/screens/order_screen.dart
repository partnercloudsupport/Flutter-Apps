import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {

  final String orderId;

  // passamos para a tela o ID do pedido
  OrderScreen(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedido Realizado", style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        //padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.check,
              color: Theme.of(context).primaryColor,
              size: 88.0,
            ),
            Text("Pedido realizado com sucesso!", style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 18.0
              ),
            ),
            Text("Número do pedido: ${orderId}", style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              fontSize: 17.0
              ),
            ),
          ],
        ),
      ),
    );
  }
}
