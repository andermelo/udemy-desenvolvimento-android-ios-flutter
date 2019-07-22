import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  _recuperarCep() async {

    String url = "http://viacep.com.br/ws/06763040/json/";
    http.Response response;

    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];
    String uf = retorno["uf"];

    print("Resposta logradouro: $logradouro");
      print("Resposta bairro: $bairro");
      print("Resposta localidade: $localidade");
      print("Resposta uf: $uf");
    
    // print("Resposta: " + response.statusCode.toString() );
    // print("Resposta: " + response.body );

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
          children: <Widget>[
            RaisedButton(
              color: Colors.yellow,
              child: Text("Clique aqui", style: TextStyle(color: Colors.green),),
              onPressed: _recuperarCep,
            ),
            Text("Resposta logradouro: " );
          ],
        ),
      ),
    );
  }
}