import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      title: "Contador de Pessoas",
      // I'm studying Column widget !
      // Widget father: Column, Sons: Text, Padding, Text
      home: new Home()));
}

// We are creating the new Widget Home which is a Widget of kind stateful
// A classe stateful criará um estado interno do app, de modo que ao mudar algo
// ele atualizará o app
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // variable counter of people
  int _people = 0;
  String _textPeople = "Pode entrar!";

  // function that change the number of people 
  void _changePeople(int delta) {
    // delta is +1 or 1
    // we need to use setState for update the screen after a change 
    setState(() {
          _people += delta;

          if(_people < 0 ) {
            _textPeople = "Mundo invertido!?";
          } else if ( _people > 15){
            _textPeople = "Lotado!";
          } else {
            _textPeople = "Pode entrar!";
          } 

        });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset("images/restaurant.jpg",
          fit: BoxFit.cover,
          height: 1000.0,
        ),
        Column(
          // Align at center the children's Column
          mainAxisAlignment: MainAxisAlignment.center,
          // Children's Column
          children: <Widget>[
            Text("Pessoas: $_people",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
            // Widget father: Padding, Son: Row
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              // Widget father: Row, sons: Padding, FlatButton
              child: Row(
                // Align at center the children's Row
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Widget father: Padding, son: FlatButton
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: FlatButton(
                      child: Text(
                        "+1",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        // The button will sum 1 to people
                        _changePeople(1);
                      },
                    ),
                  ),
                  // Widget father: Padding, son: FlatButton
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: FlatButton(
                      child: Text(
                        "-1",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold),
                      ),
                      // the button will sum -1 to people
                      onPressed: () {
                        _changePeople(-1);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Text(_textPeople,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic))
          ],
        )
      ],
    );
  }
}
