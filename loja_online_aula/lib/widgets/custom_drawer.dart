import 'package:flutter/material.dart';
import 'package:loja_online_aula/screens/login_screen.dart';
import 'package:loja_online_aula/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:loja_online_aula/models/user_model.dart';
/*
* Página responsável por Drawer (a barra de deslizar pro lado)
*
* */
class CustomDrawer extends StatelessWidget {

  final PageController pageController; // passando o controlador para que possa manipular as telas

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {

    // background do app, degradê
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

    // Widget que fará o Drawer
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
                      child: ScopedModelDescendant<UserModel>(
                          builder: (context, child, model){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // se não estiver logado, colocaremos um texto vazio
                                // se estiver logado, irá aparecer o nome do usuário
                                Text("Olá, ${!model.isLoggedIn() ? ""
                                    : model.userData["name"]}",
                                    style: TextStyle(
                                    fontSize: 18.0, fontWeight: FontWeight.bold
                                  )
                                ),
                                GestureDetector(
                                  child: Text(
                                    // se o usuario esta logado iremos mudar o texto de entrar
                                    // para sair
                                    !model.isLoggedIn() ?           // não está logado
                                    "Entre ou cadastre-se >"
                                    : "Sair"                    // está logado
                                    , style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor
                                  ),
                                  ),
                                  onTap: () {         // função chamada ao clickar no texto
                                    // se não estiver logado irá para a tela de login e cadastro
                                    if(!model.isLoggedIn()){
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) => LoginScreen())
                                      );
                                    } else {
                                      // como será o texto de sair, iremos dar logout no usuario
                                      model.singOut();
                                    }
                                  },
                                )
                              ],
                            );
                          })
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Início", pageController, 0),
              DrawerTile(Icons.list, "Produtos", pageController, 1),
              DrawerTile(Icons.location_on, "Encontre uma loja", pageController, 2),
              DrawerTile(Icons.playlist_add_check, "Meus Pedidos", pageController, 3),
            ],
          )
        ],
      ),
    );
  }
}
