import 'dart:async';
import '../ blocs/bloc_validators.dart';
import 'package:rxdart/rxdart.dart';

// ainda tenho dúvida do porque usar o Object!!!
class Bloc extends Object with Validator {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Add data to Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // Retrieve data of Stream
  // Colocamos o transformer para validar a saída da stream que será usada
  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password => _passwordController.stream.transform(validatePassword);

  // Combina as duas streams de email e password. Retorna true pois
  // email e password só irão ser 'observadas' quando forem validadas 
  Stream<bool> get submitValid => 
    Observable.combineLatest2(email, password, (e, p) => true);


  submit() {
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;

    print(validEmail + " " + validPassword);
  }


  void dispose(){
    _emailController.close();
    _passwordController.close();
  }

}