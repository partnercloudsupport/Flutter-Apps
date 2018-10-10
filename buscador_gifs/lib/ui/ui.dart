import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
// URL Search https://api.giphy.com/v1/gifs/search?api_key=G2cr5b2sq9meKXvodkZVL4XEwQ4MIBTn&q=example&limit=25&offset=0&rating=G&lang=en
// URL Trending https://api.giphy.com/v1/gifs/trending?api_key=G2cr5b2sq9meKXvodkZVL4XEwQ4MIBTn&limit=25&rating=G


class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String _search; // texto de pesquisa
  int _offset; // offset

  // função que obterá os Gifs da internet
  Future<Map>_getGifs() async {
    http.Response response;
  
    if(_search == null) // se não houver pesquisa, URL de Trending
      response = await http.get("https://api.giphy.com/v1/gifs/trending?api_key=G2cr5b2sq9meKXvodkZVL4XEwQ4MIBTn&limit=25&rating=G");
    else  // se houver pesquisa, então usar URL com o texto da pesquisa
      response = await http.get("https://api.giphy.com/v1/gifs/search?api_key=G2cr5b2sq9meKXvodkZVL4XEwQ4MIBTn&q=$_search&limit=25&offset=$_offset&rating=G&lang=en");

    return json.decode(response.body); // retornamos o texto do json. É um map
  } 

  @override
  void initState() {
    super.initState();
    
    // testando
    _getGifs().then((map) {
      print(map);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // A barra será um gif
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network("https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif"), // O title recebe um Widget. Passamos a img
        centerTitle: true,
      ),
    body: Column(
      children:[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: "Pesquise aqui!",
              labelStyle: TextStyle(
                color: Colors.white),
              border: OutlineInputBorder()
            ),
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: FutureBuilder(
            // passamos o futuro desse builder, ou seja, o comportamento do builder será baseado
            // no estado do _getGifs
            future: _getGifs(), 
            builder: (context, snapshot) {
              switch(snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return Container(
                    alignment: Alignment.center,
                    height: 200.0,
                    width: 200.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color> (Colors.white),
                      strokeWidth: 5.0,
                    ),
                  );
                default:
                  if(snapshot.hasError) return Container(); //
                  else _createGifTable(context, snapshot);
                }
              }
            ),
          )
        ],
      ),
    );
  }
   Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot) {
      return GridView.builder(
        padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // numero de elementos na horizontal
          crossAxisSpacing: 10.0, // espaçamento na horizontal
          mainAxisSpacing: 10.0, // espaçamento na vertical
        ),
        itemCount: 4, // numero de itens no GridView
        itemBuilder: (context, index) {
          return GestureDetector( // Usamos para podermos clickarmos na imagem (?)
            child: Image.network(""),
          );
        },
      );
    }
}