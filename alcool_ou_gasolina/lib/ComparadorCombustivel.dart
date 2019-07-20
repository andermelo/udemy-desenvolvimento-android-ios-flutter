import 'package:flutter/material.dart';

class ComparadorCombustivel extends StatefulWidget {
  @override
  _ComparadorCombustivelState createState() => _ComparadorCombustivelState();
}

class _ComparadorCombustivelState extends State<ComparadorCombustivel> {

  TextEditingController _controllerEtanol = TextEditingController();
  TextEditingController _controllerGasolina = TextEditingController();
  String _textoResultado = "";

  void _calcular(){
    double precoEtanol = double.tryParse(_controllerEtanol.text);
    double precoGasolina = double.tryParse(_controllerGasolina.text);
    
    if( precoEtanol == null || precoGasolina == null){
      setState(() {
        _textoResultado = "Número inválido, digite números maiores que 0 e utilzando (.)";
      });
    }else{
      
      /*
      * Se o preço do etanol divido pelo preço da gasolina
      * for >= a 0.7 é melhor abastecer com gasolina
      * senão é melhor utilizar etanol
      * */
      if((precoEtanol / precoGasolina) >= 0.7){
        setState(() {
          _textoResultado = "Melhor abastecer com gasolina"; 
        });
      }else{
        setState(() {
          _textoResultado = "Melhor abastecer com Etanol"; 
        });
      }

      _limparCampos();
      
    }
  }

  void _limparCampos(){
    _controllerEtanol.text = "";
    _controllerGasolina.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Etanol ou Gasolina"),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(0),
                  child: Image.asset(
                    "images/logo2.png",
                    fit: BoxFit.fill,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left:25, right: 25, bottom: 0, top: 10),
                  child: Text(
                    "Saiba qual a melhor opção para abastecimento do seu carro",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      ),
                    textAlign: TextAlign.center,
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Preço do Etanol, ex: 2.59"
                  ),
                  style: TextStyle(
                    fontSize: 15
                  ),
                  controller: _controllerEtanol,                
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Preço da Gasolina, ex: 3.59"
                  ),
                  style: TextStyle(
                    fontSize: 15
                  ),
                  controller: _controllerGasolina,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Calcular",
                      style: TextStyle(fontSize: 20),
                      ),
                    onPressed: _calcular,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    _textoResultado,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600
                      ),
                    textAlign: TextAlign.center,
                    ),
                )
              ],
            ),
          ),
        ),
    );
  }
}