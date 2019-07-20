// import 'package:entrada_dados/EntradaCheckbox.dart';
import 'package:entrada_dados/EntradaRadioButton.dart';
import 'package:flutter/material.dart';
// import 'package:entrada_dados/CampoTexto.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: CampoTexto(),
      // home: EntradaCheckbox(),
      home: EntradaRadioButton(),
    )
  );
}