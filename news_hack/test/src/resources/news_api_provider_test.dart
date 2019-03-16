import 'package:news_hack/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:test_api/test_api.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

// cada test é um programa diferente, por isso usamos a main function

void main() {
  // o primeiro argumento é a mensagem que indica o que queremos testar
  // o segundo argumento é uma função que faz o teste
  test('FetchTopIds returns a list of ids', () async {
    // setup of test case
    final newsApi = NewsApiProvider();
    // usamos o MockClient para simular um request
    newsApi.client =MockClient((request) async {
      // Pelo que entendi, estamos simulando a mesma resposta
      // para os requests do client de modo que não saiamos da nossa
      // api para fazer um request, e testarmos se esse request
      // é o esperado
      return Response(json.encode([1,2,3,4]), 200);
    });

    // cria a lista de Ids
    final ids = await newsApi.fetchTopIds();

    // expectation
    expect(ids, [1, 2, 3, 4]);

  });

  test('FetchItem returns a ItemModel', () async {
    final newsApi =NewsApiProvider();
    newsApi.client =MockClient((request) async {

      // criamos um map para simular o ItemModel
      // queremos somente o ID pq queremos saber se 
      // irá retornar um ItemModel que também é um map
      final jsonMap = { "id" : 123 };
      // simulando a resposta da API original
      return Response(json.encode(jsonMap), 200);
    });

    // returns a ItemModel, aqui não importa se o ID é o mesmo
    // o objetivo é saber se está retornando um ItemModel
    final item = await newsApi.fetchItem(999);

    expect(item.id, 123);

  });

}