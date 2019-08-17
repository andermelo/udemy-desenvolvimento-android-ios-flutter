import 'dart:async';
import 'package:flutter/material.dart';
import 'package:whatsapp/main.dart';
import 'package:whatsapp/model/Conversa.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp/model/Usuario.dart';
import 'package:undraw/undraw.dart';


import '../RouteGenerator.dart';

class AbaConversas extends StatefulWidget {
  @override
  _AbaConversasState createState() => _AbaConversasState();
}

class _AbaConversasState extends State<AbaConversas> {

  List<Conversa> _listaConversas = List();
  final _controller = StreamController<QuerySnapshot>.broadcast();
  Firestore db = Firestore.instance;
  String _idUsusarioLogado;

  @override
  void initState() {
    super.initState();

    _recuperarDadosUsuario();

    Conversa conversa = Conversa();
    conversa.nome = "Ana Clara";
    conversa.mensagem = "Olá, tudo bem?";
    conversa.caminhoFoto = "https://firebasestorage.googleapis.com/v0/b/whatsapp-62949.appspot.com/o/perfil%2Fperfil1.jpg?alt=media&token=52f5ce07-855c-40b6-b422-4ef6eb40c5ca";
    
    _listaConversas.add(conversa);
  }

  _recuperarDadosUsuario() async{

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado =  await auth.currentUser();
    _idUsusarioLogado = usuarioLogado.uid;

    _adicionarListenerConversas();
  }

  Stream<QuerySnapshot> _adicionarListenerConversas(){

    final Stream = db.collection("conversas")
          .document( _idUsusarioLogado )
          .collection("ultima_conversa")
          .snapshots();

    Stream.listen((dados){
      _controller.add( dados );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }

  @override
  Widget build(BuildContext context) {


    return StreamBuilder<QuerySnapshot>(
      stream: _controller.stream,
      builder: (context, snapshot){
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Carregando conversas"),
                  CircularProgressIndicator()
                ],
              ),
            );
          case ConnectionState.active:
          case ConnectionState.done:
          if ( snapshot.hasError ){
            return Text("Erro ao carregar os dados");
          }else{

            QuerySnapshot querySnapshot = snapshot.data;
            if (querySnapshot.documents.length == 0) {
              return UnDraw(
                color: temaPadrao.primaryColor,
                illustration: UnDrawIllustration.elements,
                placeholder: Text("nenhuma conversa ainda :("), //optional, default is the CircularProgressIndicator().
                errorWidget: Icon(Icons.error_outline, color: Colors.red, size: 50), //optional, default is the Text('Could not load illustration!').
              );
            }

            return ListView.builder(
              itemCount: _listaConversas.length,
              itemBuilder: (context, indice){
                
                //Recupera conversas
                List<DocumentSnapshot> conversas = querySnapshot.documents.toList();
                DocumentSnapshot item = conversas[indice];

                String urlImagem = item["caminhoFoto"];
                String tipo = item["tipoMensagem"];
                String mensagem = item["mensagem"];
                String nome = item["nome"];
                String idDestinatario = item["idDestinatario"];

                Usuario usuario = Usuario();
                usuario.nome = nome;
                usuario.urlImagem = urlImagem;
                usuario.idUsuario = idDestinatario;


                return ListTile(
                  onTap: (){
                    Navigator.pushNamed(
                      context,
                      RouteGenerator.ROTA_MENSAGENS,
                      arguments: usuario
                    ); 
                  },
                  
                  contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                  leading: CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Colors.grey,
                    backgroundImage: urlImagem != null
                    ? NetworkImage( urlImagem )
                    : null,
                  ),
                  title: Text(
                    nome,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  ),
                  subtitle: Text(
                    tipo == "texto" 
                      ? mensagem
                      : "Imagem...",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14
                    ),
                  ),
                );
              }
            );
          }
        }
      }
    );   
  }
}