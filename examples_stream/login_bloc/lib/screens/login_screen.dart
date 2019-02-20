import 'package:flutter/material.dart';
import '../src/ blocs/bloc_login.dart';
import '../src/ blocs/provider.dart';

class LoginScreen extends StatelessWidget{
  Widget build(context) {
    // passamos uma cópia da instância do bloc com o Provider
    final bloc = Provider.of(context);

    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          emailField(bloc),
          passwordField(bloc),
          SizedBox(height: 25.0,),
          submitButton(bloc)
        ],
        ),
      );
  }

  Widget emailField(Bloc bloc) {
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

  Widget passwordField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.password,
      builder: (context, snapshot){
        return TextField(
          onChanged: bloc.changePassword,
          decoration: InputDecoration(
            hintText: 'password',
            labelText: 'password',
            errorText: snapshot.error 
          ),
        );  
      },
    );
  }

  Widget submitButton(Bloc bloc) {
    // Usamos StreamBuilder pois precisamos da stream submitValid para
    // ativar o botão
    return StreamBuilder(
      // Stream que iremos escutar
      stream: bloc.submitValid,
      builder: (context, snapshot){
        return RaisedButton(
          color: Colors.blue,
          child: Text('Login'),
          // se snapshot tiver algum dado, significa que não deu nenhum erro
          onPressed: snapshot.hasData 
            ? () {} 
            : null,
        );
      },
    );
  }

}