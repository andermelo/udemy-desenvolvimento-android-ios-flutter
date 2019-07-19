import 'package:flutter/material.dart';
import 'dart:math';

void main(){
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var _frases = [
    "Mussum Ipsum, cacilds vidis litro abertis.",
    "Sapien in monti palavris qui num significa nadis i pareci latim.  ",
    "Si num tem leite então bota uma pinga aí cumpadi! Copo furadis é disculpa de bebadis, arcu quam euismod magna.",
    "Todo mundo vê os porris que eu tomo, mas ninguém vê os tombis que eu levo!",
  ];

  var _fraseGerada = "Clique abaixo para gerar uma frase";

  void _gerarFrases(){

    var numeroSorteado = Random().nextInt(_frases.length);
    setState(() {
      _fraseGerada = _frases[numeroSorteado]; 
    });
    // print(numeroSorteado);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Frases do Dia"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Container(
          // width: double.infinity,
          padding: EdgeInsets.all(16),
          // decoration: BoxDecoration(
          //   border: Border.all(width: 3,color: Colors.amber)
          // ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset("images/logo.png"),
              Text(
                _fraseGerada,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                  color: Colors.black
                ),
              ),
              RaisedButton(
                child: Text(
                  "Nova Frase",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: Colors.green,
                onPressed: _gerarFrases,
              ),
            ],
          ),
        ),
      )
    );
  }
}