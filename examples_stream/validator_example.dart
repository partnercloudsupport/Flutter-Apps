import 'dart:html';
import 'dart:async';

void main() {
  
  final InputElement input = querySelector('input');
  final DivElement div = querySelector('div');
  
  final validatorEmail = StreamTransformer.fromHandlers(
  	handleData: (inputValue, sink){
      if(inputValue.contains("@")){
        sink.add(inputValue);
      } else {
        sink.addError('Please insert a valid email');
      }
    }
  );
  
  input.onInput
    // .map pode retornar modificar um dado e retorná-lo, 
    .map((dynamic event) => event.target.value)
    .transform(validatorEmail)
    .listen(
    	(event) => div.innerHtml = '',
    	onError: (err) => div.innerHtml = err 
  	);
}