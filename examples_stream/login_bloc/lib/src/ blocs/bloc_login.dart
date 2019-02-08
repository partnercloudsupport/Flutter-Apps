import 'dart:async';
import '../ blocs/bloc_validators.dart';

// ainda tenho dúvida do porque usar o Object!!!
class Bloc extends Object with Validator {
  final _emailController = StreamController<String>();
  final _passwordController = StreamController<String>();

  // Add data to Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // Retrieve data of Stream
  // Colocamos o transformer para validar a saída da stream que será usada
  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password => _passwordController.stream.transform(validatePassword);


  void dispose(){
    _emailController.close();
    _passwordController.close();
  }

}

// Global instance of bloc
final bloc = Bloc();