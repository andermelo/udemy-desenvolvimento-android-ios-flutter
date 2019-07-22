import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // TextEditingController _controllerCep = TextEditingController();

  // Mascara de formulario: https://pub.dev/packages/flutter_masked_text
  var _controllerCepMask = new MaskedTextController(mask: '00000-000');  

  String _resultado = "Resultado";
  
  _recuperarCep() async {

    // utilizando API do site http://viacep.com.br/ 


    String cepDigitado = _controllerCepMask.text;
    cepDigitado.replaceAll('-', '');

    String url = "http://viacep.com.br/ws/${cepDigitado}/json/";
    http.Response response;

    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];
    String uf = retorno["uf"];

    // print("Resposta logradouro: $logradouro");
    // print("Resposta bairro: $bairro");
    // print("Resposta localidade: $localidade");
    // print("Resposta uf: $uf");
    
    // print("Resposta: " + response.statusCode.toString() );
    // print("Resposta: " + response.body );

    setState(() {
     _resultado = "$logradouro, $bairro - $localidade / $uf";
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço web",style: TextStyle(color: Colors.green),),
        backgroundColor: Colors.yellow,
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Digite o cep aqui"
                ),
                style: TextStyle(fontSize: 20),
                controller: _controllerCepMask,
              ),
            ),

            RaisedButton(
              color: Colors.yellow,
              child: Text("Buscar endereço", style: TextStyle(color: Colors.green),),
              onPressed: _recuperarCep,
            ),
            
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                _resultado, 
                style: TextStyle(fontSize: 15,),textAlign: TextAlign.center,
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}