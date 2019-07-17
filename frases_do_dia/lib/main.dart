import 'package:flutter/material.dart';


void main(){

  runApp(MaterialApp(
    title: "Frases do dia",
    home: Container(
      color: Colors.white,
      child: Column(
          children: <Widget>[
            FlatButton(
                onPressed: (){

                  int numero = 5;
                  int numero2 = 10;
                  int result = numero + numero2;

                  print(result);
                }, 
                child: Text("Botão",
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                      decoration: TextDecoration.none                      
                    ),
                )
              )
          ],
        ),
    ),
  ));

}
