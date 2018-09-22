import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      title: "Contador de Pessoas",
      // I'm studying Column widget !
      home: new Column(
        // Children's Column
        children: <Widget>[
          Text("Pessoas",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          Text("Pode entrar!", style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic
          ))
        ],
      )));
}
