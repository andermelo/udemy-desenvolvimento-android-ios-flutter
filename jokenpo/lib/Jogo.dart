import 'dart:math';
import 'package:flutter/material.dart';

class Jogo extends StatefulWidget {
  @override
  _JogoState createState() => _JogoState();
}

class _JogoState extends State<Jogo> {

  var _imagemApp = AssetImage("images/spock.png");
  var _mensagem = "Faça sua escolha abaixo";

  void _opcaoSelecionada(String escolhaUsuario){
    var opcoes = ["pedra", "papel", "tesoura", "lagarto", "spock"];
    var numero = Random().nextInt(opcoes.length);
    var escolhaApp = opcoes[numero];

    switch(escolhaApp){
      case "pedra" :
        setState(() {
          this._imagemApp = AssetImage("images/pedra.png");
        });
        break;
      case "papel" :
        setState(() {
          this._imagemApp = AssetImage("images/papel.png");
        });
        break;
      case "tesoura" :
        setState(() {
          this._imagemApp = AssetImage("images/tesoura.png");
        });
        break;
      case "lagarto" :
        setState(() {
          this._imagemApp = AssetImage("images/lagarto.png");
        });
        break;
      case "spock" :
        setState(() {
          this._imagemApp = AssetImage("images/spock.png");
        });
        break;
    }

    //Validação
    if(
          (escolhaUsuario == "pedra" && escolhaApp == "tesoura") || 
          (escolhaUsuario == "pedra" && escolhaApp == "lagarto") ||
          (escolhaUsuario == "tesoura" && escolhaApp == "papel") ||
          (escolhaUsuario == "tesoura" && escolhaApp == "lagarto") ||
          (escolhaUsuario == "papel" && escolhaApp == "pedra") ||
          (escolhaUsuario == "papel" && escolhaApp == "spock") ||
          (escolhaUsuario == "lagarto" && escolhaApp == "spock") ||
          (escolhaUsuario == "lagarto" && escolhaApp == "papel") ||
          (escolhaUsuario == "spock" && escolhaApp == "tesoura") ||
          (escolhaUsuario == "spock" && escolhaApp == "pedra")
      ){
        setState(() {
        this._mensagem = "Você ganhou! :)"; 
        });
    }else if(escolhaUsuario == escolhaApp){
        setState(() {
          this._mensagem = "Empate, jogue novamente :|"; 
        });
    }else{
        setState(() {
        this._mensagem = "Você perdeu! :("; 
        });
    }
    // print(escolhaApp);
    // print("Opção selecionada: $escolhaUsuario");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JokenPo"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //text
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              "Escolha do App",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          //image
          Image(image: this._imagemApp,),
          //text result
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              this._mensagem,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          //5 images
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () => _opcaoSelecionada("pedra"),
                child: Image.asset("images/pedra.png", height: 65,),
              ),
              GestureDetector(
                onTap: () => _opcaoSelecionada("papel"),
                child: Image.asset("images/papel.png", height: 65,),
              ),
              GestureDetector(
                onTap: () => _opcaoSelecionada("tesoura"),
                child: Image.asset("images/tesoura.png", height: 65,),
              ),
              GestureDetector(
                onTap: () => _opcaoSelecionada("lagarto"),
                child: Image.asset("images/lagarto.png", height: 65,),
              ),
              GestureDetector(
                onTap: () => _opcaoSelecionada("spock"),
                child: Image.asset("images/spock.png", height: 65,),
              ),

              // Image.asset("images/pedra.png", height: 65,),
              // Image.asset("images/papel.png", height: 65,),
              // Image.asset("images/tesoura.png", height: 65,),
              // Image.asset("images/lagarto.png", height: 65,),
              // Image.asset("images/spock.png", height: 65,),
            ],
          )
        ],
      ),
    );
  }
} 