import 'package:flutter/material.dart';

class EntradaRadioButton extends StatefulWidget {
  @override
  _EntradaRadioButtonState createState() => _EntradaRadioButtonState();
}

class _EntradaRadioButtonState extends State<EntradaRadioButton> {

  String _escolhaUsuario = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrada de dados RadioButton"),
      ),
      body: Container(
        child: Column(
        // child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            // Opção 1 de RadioButton c/ botao
            RadioListTile(
              title: Text("Masculino"),
              value: "m",
              groupValue: _escolhaUsuario,
              onChanged: (String escolha){
                setState(() {
                  _escolhaUsuario = escolha;
                  // print("Resultado: $escolha"); 
                });
              },
            ),
            RadioListTile(
              title: Text("Feminino"),
              value: "f",
              groupValue: _escolhaUsuario,
              onChanged: (String escolha){
                setState(() {
                  _escolhaUsuario = escolha;
                  // print("Resultado: $escolha"); 
                });
              },
            ),
            RadioListTile(
              title: Text("Etê"),
              value: "e",
              groupValue: _escolhaUsuario,
              onChanged: (String escolha){
                setState(() {
                  _escolhaUsuario = escolha;
                  // print("Resultado: $escolha"); 
                });
              },
            ),

            Padding(
              padding: EdgeInsets.all(25),
              child: RaisedButton(
                color: Colors.blue,
                padding: EdgeInsets.all(15),
                child: Text(
                  "Continuar".toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    letterSpacing: 1
                  ),
                ),
                onPressed: (){
                  print("Resultado: $_escolhaUsuario");
                },
              ),
            ),

            // Opção 2 de RadioButton s/ botao

            // Padding(
            //   padding: EdgeInsets.only(left: 25),
            //   child: Text("Masculino".toUpperCase()),
            // ),
            // Radio(
            //   value: "m", // numero ou string
            //   groupValue: _escolhaUsuario,
            //   onChanged: (String escolha){
            //     setState(() {
            //       _escolhaUsuario = escolha; 
            //     });
            //     print("Resultado: $escolha");
            //   },
            // ),
            // Padding(
            //   padding: EdgeInsets.only(left: 25),
            //   child: Text("Feminino".toUpperCase()),
            // ),
            // Radio(
            //   value: "f",
            //   groupValue: _escolhaUsuario,
            //   onChanged: (String escolha){
            //     setState(() {
            //     _escolhaUsuario = escolha;   
            //     });
            //     print("Resultado: $escolha");
            //   },
            // ),



          ],
        ),
      ),
    );
  }
}