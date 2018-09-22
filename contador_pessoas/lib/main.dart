import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      title: "Contador de Pessoas",
      // I'm studying Column widget !
      // Widget father: Column, Sons: Text, Padding, Text
      home: new Column(
        // Align at center the children's Column
        mainAxisAlignment: MainAxisAlignment.center,
        // Children's Column
        children: <Widget>[
          Text("Pessoas",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          // Widget father: Padding, Son: Row
          Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            // Widget father: Row, sons: Padding, FlatButton
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Widget father: Padding, son: FlatButton
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: FlatButton(
                    child: Text(
                      "+1",
                      style: TextStyle(color: Colors.white, fontSize: 40.0,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {},
                  ),
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
          ),
          Text("Pode entrar!", style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic
          ))
        ],
      )));
}
