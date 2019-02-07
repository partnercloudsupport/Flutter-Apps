import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
/*
*
* Essa será a classe que usaremos os atributos e funções em todo o app.
* É importante entender essa parte!
*
* */

class UserModel extends Model {

  // para termos acesso do UserModel em qualquer lugar do app, ao invés de usar o
  // ScopedModelDescendant, usaremos UserModel.of(context)
  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);

  // torna o isLoading true indicando que está carregando
  void StartLoading (bool isLoading) {
    isLoading = true;
    notifyListeners();
  }
  // torna o isLoading false
  void StopLoading (bool isLoading) {
    isLoading = false;
    notifyListeners();
  }

  // colocamos no _auth para facilitar a escrita do programa, mas terá apenas uma instancia
  // do FirebaseAuth

  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser firebaseUser; // cria um usuário do firebase
  // criamos um mapa para armazenar os dados do usuário
  Map<String, dynamic> userData = Map();

  bool isLoading = false; // essa variavel indica quando o usuario está processando algum dado

  // Para ao iniciar o app obtermos os dados de quem já estiver logado no app
  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    _loadCurrentUser();
  }

  void singUp({@required Map<String, dynamic> userData, @required String pass,
      @required VoidCallback onSucess, @required VoidCallback onFailed}) async {

    // atualizamos o estado do isLoading para
    StartLoading(isLoading);

    _auth.createUserWithEmailAndPassword(
        email: userData["email"],
        password: pass).then((user) async {// se for um sucesso, chamaremos essa função

          firebaseUser = user;
          _saveUserData(userData);
          onSucess();// chamamos a função onSucess
          StopLoading(isLoading);

    }).catchError((e) { // se falhar, chamaremos essa
      onFailed();
      StopLoading(isLoading);
    });
  }

  // função que indica se há usuário logado
  bool isLoggedIn() {
    return firebaseUser != null;
  }

  void singIn({@required String email, @required String pass,
          @required VoidCallback onSuccess, @required VoidCallback onFailed}) async {
    StartLoading(isLoading);

    _auth.signInWithEmailAndPassword(
      email: email,
      password: pass).then((user){

        firebaseUser = user;
        _loadCurrentUser(); // quando logarmos iremos atualizar os dados

        onSuccess(); // se o login deu certo, chamamos o onSucess

        }).catchError((e){
          onFailed(); // se deu errado, chamamos onFailed
    });

  }

  Future<Null> _loadCurrentUser() async {
    // Se não tiver nenhuma conta logada, tentaremos logar na conta atual a conta salva no app
    if(firebaseUser == null)
      firebaseUser = await _auth.currentUser();
    // se temos o usuário, mas seus dados não foram carregados, então iremos carregar
    if(firebaseUser != null){
      if(userData["name"] == null){
        // estamos retornando os documentos para um DocumentSnapshot
        DocumentSnapshot docData = await Firestore.instance.collection("users")
            .document(firebaseUser.uid).get();
        // pegaremos os dados do docData e salvar no userData
        userData = docData.data;
      }
    }
    notifyListeners();
  }

  void singOut(){
    _auth.signOut(); // deslogamos o usuario
    userData = Map(); // atribuimos um mapa vazio ao usuário
    firebaseUser = null; // atribuimos null pro usuario atual, ou seja, deslogamos ele

    notifyListeners();
  }

  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(
        email: email
    );
  }
  // O userData do user_model irá receber o userData passado no parâmetro
  Future<Null> _saveUserData (Map<String, dynamic> userData) async{
    this.userData = userData;
    // estamos salvando no firebase na coleção users no documento do user ID e salvando
    // os dados passados no map userData que é o map que contém os dados do usuário
     await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData);
  }

}