import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      title: "Contador de Pessoas",
      // I'm studying Column widget !
      // Widget father: Column, Sons: Text, Row, Text
      home: new Column(
        // Children's Column
        children: <Widget>[
          Text("Pessoas",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          // Widget father: Row, Sons: FlatButton, FlatButton
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text(
                  "+1",
                  style: TextStyle(color: Colors.white, fontSize: 40.0,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {},
              ),
              FlatButton(
                child: Text(
                  "-1", style: TextStyle(
                  color: Colors.green, fontSize: 40.0, fontWeight: FontWeight.bold,
                ),),
                onPressed: () {},
              ),
            ],
          ),
          Text("Pode entrar!", style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic
          ))
        ],
      )));
}
