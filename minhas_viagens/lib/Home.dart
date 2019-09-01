import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Mapa.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _controller = StreamController<QuerySnapshot>.broadcast();
  Firestore _db = Firestore.instance;

  _abrirMapa(String idViagem){

     Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (_) => Mapa(idViagem: idViagem,)
      )
    );

  }

  _excluirViagem(String idViagem){
    
    _db.collection("viagens").document(idViagem).delete();

  }

  _adicionarLocal(){

    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (_) => Mapa()
      )
    );
  }

  _adicionarListenerViagens() async{
    final stream = _db.collection("viagens")
          .snapshots();

    stream.listen((dados){
      _controller.add(dados);
    });
  }


  @override
  void initState() {
    super.initState();

    _adicionarListenerViagens();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Minhas Viagens"),),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color(0xff0066cc),
        onPressed: (){_adicionarLocal();},
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _controller.stream,
        builder: (context, snapshot){
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
            case ConnectionState.done:

              QuerySnapshot querySnapshot = snapshot.data;
              List<DocumentSnapshot> viagens = querySnapshot.documents.toList();

              return Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemCount: viagens.length,
                        itemBuilder: (context, index){

                          DocumentSnapshot item = viagens[index];
                          String titulo = item["titulo"];
                          String idViagem = item.documentID;

                          
                          return GestureDetector(
                            onTap: (){_abrirMapa(idViagem);},
                            child: Card(
                              child: ListTile(
                                title: Text(titulo),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: (){_excluirViagem(idViagem);},
                                      child: Padding(
                                        padding: 
                                        EdgeInsets.all(8),
                                        child: Icon(
                                          Icons.remove_circle,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                );
              break;
          }
        },
      ),
    );
  }
}

/*
Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _listaViagens.length,
              itemBuilder: (context, index){
                String titulo = _listaViagens[index];
                return GestureDetector(
                  onTap: (){_abrirMapa();},
                  child: Card(
                    child: ListTile(
                      title: Text(titulo),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){_excluirViagem();},
                            child: Padding(
                              padding: 
                              EdgeInsets.all(8),
                              child: Icon(
                                Icons.remove_circle,
                                color: Colors.orange,
                              ),
                            ),
                            
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      )
      */