import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // retirar aviso debug
    title: "Frases do dia",
    home: Container(
      margin: EdgeInsets.only(top: 40),
      decoration: BoxDecoration(
        border: Border.all(width: 3, color: Colors.white)
      ),
      // color: Colors.white,
      child: Image.asset(
        "images/mesa.jpg",
        fit: BoxFit.scaleDown,
      ),
    ),
  ));

}
