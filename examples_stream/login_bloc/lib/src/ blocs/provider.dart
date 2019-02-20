import 'package:flutter/material.dart';
import 'bloc_login.dart';

class Provider extends InheritedWidget {
  final bloc = Bloc(); // instance of Bloc

  Provider({Key key, Widget child})
  : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  // provider, retorna a instancia do bloc = Bloc();
  static Bloc of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).bloc;
  }
}