import 'package:flutter/material.dart';
import 'package:whatsapp/Cadastro.dart';
import 'package:whatsapp/Configuracoes.dart';
import 'package:whatsapp/Home.dart';
import 'package:whatsapp/Login.dart';

class RouteGenerator {

  static const String ROTA_HOME = "/home";
  static const String ROTA_LOGIN = "/login";
  static const String ROTA_CADASTRO = "/cadastro";
  static const String ROTA_CONFIGURACOES = "/configuracoes";



  static Route<dynamic>  generateRoute(RouteSettings settings){

    switch (settings.name) {
      case '/' :
        return MaterialPageRoute(
          builder: (_) => Login()
        );
        break;
      case ROTA_LOGIN :
        return MaterialPageRoute(
          builder: (_) => Login()
        );
        break;
      case ROTA_CADASTRO :
        return MaterialPageRoute(
          builder: (_) => Cadastro()
        );
        break;
      case ROTA_HOME :
        return MaterialPageRoute(
          builder: (_) => Home()
        );
        break;
      case ROTA_CONFIGURACOES :
        return MaterialPageRoute(
          builder: (_) => Configuracoes()
        );
        break;
      default: 
        _erroRota();
    }
  }

  static Route<dynamic> _erroRota(){
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        appBar: AppBar(title: Text("Tela não encontrada!"),),
        body: Center(
          child: Text("Tela não encontrada!"),
        ),
      );
    });
  }

}