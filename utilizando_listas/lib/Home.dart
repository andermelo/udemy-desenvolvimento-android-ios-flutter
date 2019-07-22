import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _itens = [];

  void _carregarItens(){
    for(int i=0; i<=100; i++){
      Map<String, dynamic> item = Map();
      item["titulo"] = "Titulo ${i} Lorem ipsum dolor sit amet.";
      item["descricao"] = "descricao ${i} Lorem ipsum dolor sit amet.";
      _itens.add( item );
    }
  }

  @override
  Widget build(BuildContext context) {

    _carregarItens();

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: ListView.builder(
          itemCount: _itens.length,
          itemBuilder: (context,indice){

            // Map<String, dynamic> item = _itens[indice];
            // print("item ${_itens[indice]["titualo"]}");

            return ListTile(
              title: Text(_itens[indice]["titulo"]),
              subtitle: Text(_itens[indice]["descricao"]),
            );
          },
        ),
      ),
    );
  }
}