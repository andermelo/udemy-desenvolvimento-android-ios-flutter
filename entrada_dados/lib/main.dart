// import 'package:entrada_dados/CampoTexto.dart';
import 'package:entrada_dados/EntradaCheckbox.dart';
// import 'package:entrada_dados/EntradaRadioButton.dart';
// import 'package:entrada_dados/EntradaSlider.dart';
// import 'package:entrada_dados/EntradaSwitch.dart';
import 'package:flutter/material.dart';


void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: CampoTexto(),
      home: EntradaCheckbox(),
      // home: EntradaRadioButton(),
      // home: EntradaSwitch(),
      // home: EntradaSlider(),
    )
  );
}