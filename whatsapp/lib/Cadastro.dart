import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp/model/Usuario.dart';
import 'Home.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  //Controladores
  TextEditingController _controllerNome = TextEditingController(text: "Anderson Melo");
  TextEditingController _controllerEmail = TextEditingController(text: "andersonmelo@gmail.com");
  TextEditingController _controllerSenha = TextEditingController(text: "123456");

  String _mensagemErro = '';

  _validarCampos(){
    //Recuperar dados dos campos
    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (nome.length >= 3) {
      if (email.isNotEmpty && email.contains("@")) {
        if (senha.isNotEmpty && senha.length >= 6) {
          setState(() {
           _mensagemErro = ''; 
          });

          Usuario usuario = Usuario();
          usuario.nome = nome;
          usuario.email = email;
          usuario.senha = senha;

          _cadastrarUsuario(usuario);
        
        } else {
          setState(() {
            _mensagemErro = "Preencha uma senha válida apartir de 6 caracteres"; 
          });
        }
      } else {
        setState(() {
          _mensagemErro = "Preencha um e-mail válido"; 
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Nome precisa ter mais que 3 caracteres"; 
      });
    }
  }

  _cadastrarUsuario(Usuario usuario){

    FirebaseAuth auth = FirebaseAuth.instance;

    auth.createUserWithEmailAndPassword(
      email: usuario.email,
      password: usuario.senha,
    ).then((firebaseUser){

      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => Home()
        )
      );
    }).catchError((erro){
      print("Erro: " + erro.toString() );

      setState((){
        _mensagemErro = "Sucesso ao cadastrar usuario"; 
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
      ),
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
                    "images/usuario.png", width: 200, height: 150,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerNome,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Nome",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(36)
                      )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
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
                    controller: _controllerSenha,
                    obscureText: true,
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
                        "Cadastrar",
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