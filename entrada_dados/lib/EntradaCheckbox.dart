import 'package:flutter/material.dart';

class EntradaCheckbox extends StatefulWidget {
  @override
  _EntradaCheckboxState createState() => _EntradaCheckboxState();
}

class _EntradaCheckboxState extends State<EntradaCheckbox> {

  bool _comidaBrasileira = false;
  bool _comidaMexicana = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrada de dados CheckBox"),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            CheckboxListTile(
              title: Text("Comida Brasileira"),
              subtitle: Text("Uma das melhores comida do mundo"),
              activeColor: Colors.amber,
              // selected: true,
              secondary: Icon(Icons.add_box),
              value: _comidaBrasileira,
              onChanged: (bool valor){
                setState(() {
                  _comidaBrasileira = valor; 
                });
              },            
            ),
            CheckboxListTile(
              title: Text("Comida Mexicana"),
              subtitle: Text("Uma das melhores comida do mundo"),
              activeColor: Colors.amber,
              // selected: true,
              secondary: Icon(Icons.add_box),
              value: _comidaMexicana,
              onChanged: (bool valor){
                setState(() {
                  _comidaMexicana = valor; 
                });
              },            
            ),

            Padding(
              padding: EdgeInsets.all(20),
              child: RaisedButton(
              color: Colors.blue,
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Text(
                "Salvar",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              onPressed: (){
                print(
                  "Comida Brasileira: " + _comidaBrasileira.toString() + " "
                  "Comida Mexicana: " + _comidaMexicana.toString() 
                );
              },
            ),
            )

            // Padding(
            //   padding: EdgeInsets.all(15),
            //   child: Text("Comida Brasileira"),
            // ),
            // Checkbox(
            //   value: _estaSelecionado,
            //   onChanged: (bool valor){
            //     setState(() {
            //      _estaSelecionado = valor; 
            //     });
            //   },
            // )

          ],
        ),
      ),
    );
  }
}