import 'package:flutter/material.dart';

class Jogo extends StatefulWidget {
  @override
  _JogoState createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jokenpo"),
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
          GestureDetector(
            onLongPress: (){print("Imagem clicada");},
            child: Image.asset("images/padrao.png"),
          ),
          //text result
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              "Faça sua escolha abaixo",
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
              Image.asset("images/pedra.png", height: 65,),
              Image.asset("images/papel.png", height: 65,),
              Image.asset("images/tesoura.png", height: 65,),
              Image.asset("images/lagarto.png", height: 65,),
              Image.asset("images/spock.png", height: 65,),
            ],
          )
        ],
      ),
    );
  }
} 