import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future main() async {
  // exemplo de leitura de todos os arquivos da coleção usuarios

  QuerySnapshot snapshot =
      await Firestore.instance.collection("usuarios").getDocuments();

  // para doc (DocumentSnapshot) na lista de documentos em snapshot irá printar os dados
  for (DocumentSnapshot doc in snapshot.documents) {
    print(doc.data);
  }

  // Para 'escutarmos' o nosso banco de dados para caso de algum dado ser modificado usamos:

  Firestore.instance.collection("usuarios").snapshots().listen((snapshotAux) {
    for (DocumentSnapshot doc in snapshotAux.documents) {
      print(doc.data);
    }
  });

  runApp(MyApp());
}

// Definindo os temas do app

final ThemeData kIOSTheme = ThemeData(
    primarySwatch: Colors.orange,
    primaryColor: Colors.grey[100],
    primaryColorBrightness: Brightness.light);

final ThemeData kDefaultTheme = ThemeData(
    primarySwatch: Colors.purple, accentColor: Colors.orangeAccent[400]);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chat Online",
      debugShowCheckedModeBanner: false,
      // ? caso true e : caso false
      theme: Theme.of(context).platform == TargetPlatform.iOS
          ? kIOSTheme
          : kDefaultTheme,
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Chat Online"),
          centerTitle: true,
          elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        ),
        body: Column(
          children: <Widget>[
            Expanded( // Usei o Expanded para ocupar to;do o espaço possivel na tela
              child: ListView( // ListView para ter a lista das mensagens com o ChatMessage
                children: <Widget>[
                  ChatMessage(),
                ],
              ),
            ),
            Divider(
              height: 1.0
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: TextComposer(),
            )
          ],
        ),
      ),
    );
  }
}

class TextComposer extends StatefulWidget {
  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  bool _isComposing =
      false; // bool que controla o estado do botão de enviar mensagem

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      // para todos os icones dentro IconTheme as cores serão as definidas no tema
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        // margin é um espaçamento dentro do container, padding é fora
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        // definindo um tema para apenas a plataforma IOS
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[200])))
            : null,
        child: Row(
          children: <Widget>[
            // icone da camera
            Container(
              child:
                  IconButton(icon: Icon(Icons.photo_camera), onPressed: () {}),
            ),
            // Campo de texto para o usuário mandar mensagem
            Expanded(
              child: TextField(
                decoration:
                    InputDecoration.collapsed(hintText: "Enviar uma mensagem"),
                onChanged: (text) {
                  setState(() {
                    _isComposing = text.length >
                        0; // se tiver mais ou igual que um caractere o botao é ativado
                  });
                },
              ),
            ),
            Container( // container do botao enviar
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Theme.of(context).platform == TargetPlatform.iOS
                    ? CupertinoButton(
                        child: Text("Enviar"),
                        onPressed: _isComposing
                            ? () {}
                            : null // A ação só irá acontecer caso o usuario esteja digitando algo
                        )
                    : IconButton(
                        icon: Icon(Icons.send),
                        onPressed: _isComposing
                            ? () {}
                            : null // A ação só irá acontecer caso o usuario esteja digitando algo
                        ))
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage("https://static7.depositphotos.com/1004841/738/i/450/depositphotos_7381892-stock-photo-flag-of-brazil.jpg"),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Thiago",
                  style: Theme.of(context).textTheme.subhead,
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: Text(
                    "teste"
                  ),
                )
              ],
            )
          )
        ],
      ),
    );
  }
}

