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

  String _search;
  int _offset;

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
    return Container(
    );
  }
}