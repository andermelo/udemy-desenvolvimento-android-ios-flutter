import 'package:flutter/material.dart';

class EntradaSwitch extends StatefulWidget {
  @override
  _EntradaSwitchState createState() => _EntradaSwitchState();
}

class _EntradaSwitchState extends State<EntradaSwitch> {

  bool _escolhaUsuario = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrada de dados Switch"),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            SwitchListTile(
              // activeColor: Colors.red,
              title: Text("Tema Escuro".toUpperCase()),
              value: _escolhaUsuario,
              onChanged: (bool valor){
                setState(() {
                  _escolhaUsuario = valor; 
                });
              },
            ),

            Padding(
              padding: EdgeInsets.all(10),
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
                  if(_escolhaUsuario){
                    print("Ativar tema escuro");
                  }else{
                    print("Não ativar tema escuro");
                  }
                  // print("Resultado: $_escolhaUsuario");
                },
              ),
            ),

            // Switch(
            //   value: _escolhaUsuario,
            //   onChanged: (bool valor){
            //     setState(() {
            //       _escolhaUsuario = valor; 
            //     });
            //   },
            // ),
            // Text("Receber notificações?"),


          ],
        ),
      ),
    );
  }
}