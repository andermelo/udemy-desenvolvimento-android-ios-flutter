import 'package:flutter/material.dart';

class EntradaSlider extends StatefulWidget {
  @override
  _EntradaSliderState createState() => _EntradaSliderState();
}

class _EntradaSliderState extends State<EntradaSlider> {

  double valor = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrada de dados Slider"),
      ),
      body: Container(
        padding: EdgeInsets.all(60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Slider(
              value: valor,
              min: 0,
              max: 100,
              label: "Valor " + valor.toString(),
              divisions: 10,
              activeColor: Colors.red,
              inactiveColor: Colors.green,
              onChanged: (double novoValor){
                setState(() {
                  valor = novoValor; 
                });
                print("Valor selecionado: " + novoValor.toString());
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
                  print("Valor selecionado: " + valor.toString());
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.all(25),
              child: Text("Valor selecionado: " + valor.toString()),
            ),

          ],
        ),
      ),
    );
  }
}