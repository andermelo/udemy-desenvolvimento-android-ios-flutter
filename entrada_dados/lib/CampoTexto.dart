import 'package:flutter/material.dart';

class CampoTexto extends StatefulWidget {
  @override
  _CampoTextoState createState() => _CampoTextoState();
}

class _CampoTextoState extends State<CampoTexto> {

  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrada de dados"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(25),
            child: TextField(
              //text
              // keyboardType: TextInputType.text,
              //number
              keyboardType: TextInputType.number,
              //emailAddress
              // keyboardType: TextInputType.emailAddress,
              //datetime
              // keyboardType: TextInputType.datetime,

              decoration: InputDecoration(
                labelText: "Digite um valor",
              ),

              enabled: true, // desabilitar um campo
              
              maxLength: 5, //tamanho maximo de caracteres
              maxLengthEnforced: false, //permite ir alem do definido em maxLength, o padrao é true.

              style: TextStyle(
                color: Colors.green,
                fontSize: 25,
              ),

              obscureText: false, // para campos de senha, padrao é false

              // onChanged: (String texto){
              //   print("valor digitado: $texto");
              // },

              onSubmitted: (String texto){
                print("valor digitado: $texto");
              },
              controller: _textEditingController,

            ),
          ),
          RaisedButton(
            child: Text("Salvar"),
            color: Colors.lightGreen,
            onPressed: (){
              print("valor digitado:" + _textEditingController.text);
            },
          )
        ],
      ),
    );
  }
}