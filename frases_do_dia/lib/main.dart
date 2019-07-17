import 'package:flutter/material.dart';


void main(){

  runApp(MaterialApp(
    title: "Frases do dia",
    home: Container(
      color: Colors.white,
      child: Column(
          children: <Widget>[
          Text(
              "Mussum Ipsum",
              style: TextStyle(
                fontSize: 50,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.normal,
                letterSpacing: 0,
                wordSpacing: 0,
                decoration: TextDecoration.underline,
                decorationColor: Colors.black,
                decorationStyle: TextDecorationStyle.solid,
                color: Colors.blue),
            ),
          ],
        ),
    ),
  ));

}
