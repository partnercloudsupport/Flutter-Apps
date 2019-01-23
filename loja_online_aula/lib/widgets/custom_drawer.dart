import 'package:flutter/material.dart';
import 'package:loja_online_aula/tiles/drawer_tile.dart';

class Custom_Drawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // o fundo do app, degradê
    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 203, 236, 241),
                Colors.white
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
          )
      ),
    );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                height: 170.0,
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                margin: EdgeInsets.only(bottom: 8.0),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0, // distancia do margem topo
                      left: 0.0, // distancia da margem esquerda
                      child: Text("Loja Online", style:
                        TextStyle(
                          fontSize: 34.0, fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Olá,", style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold
                            ),
                          ),
                          GestureDetector(
                            child: Text("Entre ou cadastre-se >", style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor
                              ),
                            ),
                            onTap: () { // função chamada ao clickar no texto

                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Início"),
              DrawerTile(Icons.list, "Produtos"),
              DrawerTile(Icons.location_on, "Encontre uma loja"),
              DrawerTile(Icons.playlist_add_check, "Meus Pedidos"),
            ],
          )
        ],
      ),
    );
  }
}
