import 'package:flutter/material.dart';
import '../src/ blocs/bloc_login.dart';

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
    // se nosso stream entrar algum dado, refazemos todo o builder
    return StreamBuilder(
      stream: bloc.email, // stream that provides our email
      // snapshot é o dado que será passado pela stream bloc.email
      builder: (context, snapshot){
        return TextField(
          onChanged: bloc.changeEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "you@email.com",
            labelText: "you@email.com",
            errorText: snapshot.error
          ),
        );
      },
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