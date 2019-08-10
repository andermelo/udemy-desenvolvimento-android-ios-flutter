import 'package:flutter/material.dart';
import 'Cadastro.dart';
import 'package:whatsapp/model/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  //Conroladores
  TextEditingController _controllerEmail = TextEditingController(text: "andersonmelo@gmail.com");
  TextEditingController _controllerSenha = TextEditingController(text: "123456");
  String _mensagemErro = '';

    _validarCampos(){
    //Recuperar dados dos campos
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (email.isNotEmpty && email.contains("@")) {
      if (senha.isNotEmpty && senha.length >= 6) {
        setState(() {
        _mensagemErro = ''; 
        });

        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;

        _logarUsuario(usuario);
       
      }else{
        setState(() {
          _mensagemErro = "Preencha uma senha"; 
        });
      }
    }else{
      setState(() {
        _mensagemErro = "Preencha um e-mail válido"; 
      });
    }
  }

  _logarUsuario(Usuario usuario){

    FirebaseAuth auth = FirebaseAuth.instance;

    auth.signInWithEmailAndPassword(
      email: usuario.email,
      password: usuario.senha
    ).then((firebaseUser){

      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(
          builder: (context) => Home()
        )
      );

    }).catchError((erro){
      setState(() {
        _mensagemErro = "Erro ao autenticar usuário, verifique e-mail e senha"; 
      });
    });
  }

  Future _verificarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    // auth.signOut();

    FirebaseUser usuarioLogado = await auth.currentUser();
    if (usuarioLogado != null) {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(
          builder: (context) => Home()
        )
      );
    } 
  }

  @override
  void initState() {
    _verificarUsuarioLogado();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xff075e54)),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    "images/logo.png", width: 200, height: 150,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    autofocus: true,
                    controller: _controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "E-mail",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(36)
                      )
                    ),
                  ),
                ),
                TextField(
                    obscureText: true,
                    controller: _controllerSenha,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Senha",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(36)
                      )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 10),
                    child: RaisedButton(
                      child: Text(
                        "Entrar",
                        style: TextStyle(fontSize:20,color:Colors.white),
                      ),
                      color: Colors.green,
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                      onPressed: (){
                        _validarCampos();
                      },

                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      child: Text("Não tem conta? cadastre-se!",
                      style:TextStyle(
                        color: Colors.white
                        )                        
                      ),
                      onTap: (){
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => Cadastro()
                          )
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      _mensagemErro,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.yellow,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}