import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget{
  Widget build(context) {
   
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          emailField(),
          passwordField(),
          SizedBox(height: 25.0,),
          submitButton()
        ],
        ),
      );
  }

  Widget emailField() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: "you@email.com",
        labelText: "you@email.com"
      ),
    );
  }

  Widget passwordField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'password',
        labelText: 'password'
      ),
    );
  }

  Widget submitButton() {
    return RaisedButton(
      color: Colors.blue,
      child: Text('Login'),
      onPressed: () {},
    );
  }

}