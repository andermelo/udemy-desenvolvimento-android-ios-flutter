import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main(){
  runApp(
    MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    )
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _preco = '0';

  void _recuperPreco() async{

    String url = "https://blockchain.info/ticker"; 

    http.Response response = await http.get(url);

    Map<String, dynamic> retorno = json.decode(response.body);

    setState(() {
     _preco =  retorno["BRL"] ["buy"].toString();
    });

    // print(retorno["BRL"] ["buy"].toString());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Padding(
              padding: EdgeInsets.all(30),
              child: Image.asset("images/bitcoin.png"),
            ),

            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "R\$ $_preco", 
                textAlign: TextAlign.center, 
                style: TextStyle(fontSize: 28,color: Colors.black, fontWeight: FontWeight.w400),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(30),
              child: RaisedButton(
                padding: EdgeInsets.only(top: 30,bottom: 30),
                color: Colors.orange,
                child: Text("Atualizar".toUpperCase(), style:TextStyle(color: Colors.white,fontSize: 15)),
                onPressed: _recuperPreco,
              ),
            )
            
          ],
        ),
      ),
    );
  }
}