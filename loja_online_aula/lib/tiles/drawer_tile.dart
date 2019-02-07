import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

  final IconData icon;
  final String text;
  final PageController pageController;// controlador das telas
  final int page; // numero da pagina

  DrawerTile(this.icon, this.text, this.pageController, this.page); // construtor onde passamos o icone e o texto do DrawerTile

  @override
  Widget build(BuildContext context) {

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop(); // fechamos a tela
          pageController.jumpToPage(page);// função que 'pula' pra tela especificada

        },
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                size: 32.0,
                // se o numero da pagina for igual a da atual, irá ser verde, caso contrário, cinza
                color: pageController.page.round() == page ?
                    Theme.of(context).primaryColor :
                    Colors.grey[700]
              ),
              SizedBox(width: 32.0),
              Text(text, style: TextStyle(
                fontSize: 16.0,
                color: pageController.page.round() == page ?
              Theme.of(context).primaryColor :
                  Colors.grey[700]
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
