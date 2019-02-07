import 'package:flutter/material.dart';
import 'package:loja_online_aula/tabs/home_tab.dart';
import 'package:loja_online_aula/tabs/orders_tab.dart';
import 'package:loja_online_aula/tabs/places_tab.dart';
import 'package:loja_online_aula/tabs/products_tab.dart';
import 'package:loja_online_aula/widgets/cart_buttom.dart';
import 'package:loja_online_aula/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {



  final _pageController = PageController(); // controlador das telas

  @override
  Widget build(BuildContext context) {
    // Widget que fará mudança de telas
    // A mudança de telas é feita por ordem.
    return PageView(
      controller: _pageController,
      // desabilita função de rolar pro lado a tela
      physics: NeverScrollableScrollPhysics(),

      children: <Widget>[

        // Usamos o Scaffold para utilizar o CustomDrawer

        Scaffold(
          floatingActionButton: CartButton(),
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),

        Scaffold(
          floatingActionButton: CartButton(),
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          body: ProductsTab(),
          drawer: CustomDrawer(_pageController),
        ),

        Scaffold(
          appBar: AppBar(
            title: Text("Locais"),
            centerTitle: true,
          ),
          body: PlacesTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Meus Pedidos"),
          ),
          body: OrdersTab(),
          drawer: CustomDrawer(_pageController),
        )
      ],
    );
  }
}
