import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
      title: "Meu Restaurante", // a example of optional parameter
      home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _people = 0; // this variable just can see here
  String _infoText = "Pode Entrar"; // this variable just can see here

  void _changePeople(int delta) {
    setState(() {
      _people += delta;
      if(_people < 0) {
        _infoText = "Mundo invertido!?";
      } else if(_people <= 10) {
        _infoText = "Pode Entrar!";
      } else {
        _infoText = "Lotado!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "images/restaurant.jpeg",
          fit: BoxFit.cover,
          height: 800.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Pessoas = $_people",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: FlatButton(
                        child: Text(
                          "1",
                          style: TextStyle(color: Colors.white, fontSize: 30.0),
                        ),
                        onPressed: () {
                          _changePeople(
                              1); //  The function that change the variable people and update the screen
                          debugPrint("+1");
                        })),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: FlatButton(
                        child: Text(
                          "-1",
                          style: TextStyle(color: Colors.white, fontSize: 30.0),
                        ),
                        onPressed: () {
                          _changePeople(
                              -1); //  The function that change the variable people and update the screen
                          debugPrint("-1");
                        }))
              ],
            ),
            Text(
              _infoText,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontStyle: FontStyle.italic),
            )
          ],
        )
      ],
    );
  }
}
