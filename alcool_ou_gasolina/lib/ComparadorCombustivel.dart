import 'package:flutter/material.dart';

class ComparadorCombustivel extends StatefulWidget {
  @override
  _ComparadorCombustivelState createState() => _ComparadorCombustivelState();
}

class _ComparadorCombustivelState extends State<ComparadorCombustivel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Etanol ou Gasolina"),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(0),
              child: Image.asset(
                "images/logo2.png",
                fit: BoxFit.fill,
              ),
            ),

            // Image.asset("images/logo.png"),

            Padding(
              padding: EdgeInsets.only(left:25, right: 25, bottom: 0, top: 0),
              child: Text(
                "Saiba qual a melhor opção para abastecimento do seu carro",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  ),
                textAlign: TextAlign.center,
              ),
            )

            FlatButton(
              onPressed: (){

              },
            ),
          ],
        ),
    );
  }
}