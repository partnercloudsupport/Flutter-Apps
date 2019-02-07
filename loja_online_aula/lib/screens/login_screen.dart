import 'package:flutter/material.dart';
import 'package:loja_online_aula/models/user_model.dart';
import 'package:loja_online_aula/screens/singup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  // estamos definindo a key dos formulários
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Entrar"),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              child: Text("CRIAR CONTA", style: TextStyle(
                fontSize: 15.0,
              ),
              ),
              textColor: Colors.white,
              onPressed: () {
                // usamos o place pushReplacement para não voltarmos para essa tela
                // ou seja, ao irmaos para tela de cadastro, ao voltar, voltaremos
                // para a pagina anterior a essa, que é a LoginScreen
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SingUpScreen())
                );
              },
            )
          ],
        ),
        // Estamos habilitando o formulário acessar nosso UserModel
        body: ScopedModelDescendant<UserModel>(
            builder: (context, child, model){
              // se estamos processando algum dado, iremos usar O CircularProgressIndicator
              if(model.isLoading)
                return Center(
                  child: CircularProgressIndicator(),
                );

              // se não estiver, retornamos o Form
              return Form( // usamos Form pois teremos formulários
                // Usamos o ListView para poder rolar a tela!!!
                  key: _formKey,
                  child: ListView(
                    padding: EdgeInsets.all(16.0),
                    children: <Widget>[
                      TextFormField(
                        controller: _emailController,
                        validator: (text){
                          // se o texto for vazio ou não conter @ retornará a mensagem
                          // e-mail invalido
                          if(text.isEmpty || !text.contains("@")) return "E-mail inválido";
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: "E-mail"
                        ),
                      ),
                      SizedBox(height: 16.0,),
                      TextFormField(
                        controller: _passController,
                        validator: (text){
                          // se o texto for vazio ou a senha tiver menos de 6 caracteres
                          // retorna a mensagem de erro
                          if(text.isEmpty || text.length < 6) return "Senha inválida";
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Senha"
                        ),
                      ),
                      TextFormField(

                        controller: ,
                        validator: (text){
                          if(text.length >)
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Senha"
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          child: Text("Esqueci minha senha",
                            textAlign: TextAlign.right,
                          ),
                          padding: EdgeInsets.zero,
                          onPressed: (){
                            if(_emailController.text.isEmpty){
                              _scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content: Text("Digite seu e-mail!"),
                                  backgroundColor: Colors.redAccent,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                            else{
                              // função que envia o email de recuperação de senha
                              model.recoverPass(_emailController.text);

                              _scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content: Text("Confira seu e-mail!"),
                                  backgroundColor: Theme.of(context).primaryColor,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          }
                        ),
                      ),
                      SizedBox(height: 16.0,),
                      // Para padronizar o tamanho do botão, coloquei 44.0
                      SizedBox(height: 44.0,
                        child: RaisedButton(
                          child: Text("Entrar", style: TextStyle(
                              fontSize: 18.0
                          ),
                          ),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          onPressed: (){
                            // estamos pedindo para saber validar os campos de acordo
                            // com a key passada no TextFormField
                            if(_formKey.currentState.validate()){
                              model.singIn(
                                  email: _emailController.text,
                                  pass: _passController.text,
                                  onSuccess: _onSuccess,
                                  onFailed: _onFailed
                              );
                            }
                          },
                        ),
                      ),

                    ],
                  )
              );
            })
    );
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFailed() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Falha ao realizar Login"),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
