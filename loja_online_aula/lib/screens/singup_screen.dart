import 'package:flutter/material.dart';
import 'package:loja_online_aula/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SingUpScreen extends StatefulWidget {
  @override
  _SingUpScreenState createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {

  final _formKey = GlobalKey<FormState>();
  // chave para utilizarmos o scaffold noutra função
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Cadastre-se"),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<UserModel>(
            builder: (context, child, model){
              return Form( // usamos Form pois teremos formulários
                // Usamos o ListView para poder rolar a tela!!!
                  key: _formKey,
                  child: ListView(
                    padding: EdgeInsets.all(16.0),
                    children: <Widget>[
                      TextFormField(
                        controller: _nameController,
                        validator: (text){
                          // se o texto for vazio ou não conter retornará a mensagem
                          // nome invalido
                          if(text.isEmpty) return "Nome inválido";
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: "Nome Completo"
                        ),
                      ),
                      SizedBox(height: 16.0,),
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
                      SizedBox(height: 16.0,),
                      TextFormField(
                        controller: _addressController,
                        validator: (text){
                          // se o texto for vazio ou a senha tiver menos de 6 caracteres
                          // retorna a mensagem de erro
                          if(text.isEmpty) return "Endereço inválida";
                        },
                        decoration: InputDecoration(
                            hintText: "Endereço"
                        ),
                      ),
                      SizedBox(height: 16.0,),
                      // Para padronizar o tamanho do botão, coloquei 44.0
                      SizedBox(height: 44.0,
                        child: RaisedButton(
                          child: Text("Cadastrar", style: TextStyle(
                              fontSize: 18.0
                          ),
                          ),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          onPressed: (){
                            // estamos pedindo para saber validar os campos de acordo
                            // com a key passada no TextFormField

                            // salvamos em um mapa os dados a serem salvos no banco de dados do usuario
                            Map<String, dynamic> userData = {
                              "name" : _nameController.text,
                              "email" : _emailController.text,
                              "address" : _addressController.text
                            };

                            if(_formKey.currentState.validate()){
                              model.singUp(
                                  userData: userData,
                                  pass: _passController.text,
                                  onSucess: _onSucess,
                                  onFailed: _onFailed,
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

  void _onSucess() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Usuário criado com sucesso!"),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 2),
      ),
    );
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });
  }

  void _onFailed() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Falha ao criar usuário"),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
  }

}
