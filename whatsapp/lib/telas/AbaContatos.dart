import 'package:flutter/material.dart';
import 'package:whatsapp/model/Usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AbaContatos extends StatefulWidget {
  @override
  _AbaContatosState createState() => _AbaContatosState();
}

class _AbaContatosState extends State<AbaContatos> {

  String _idUsusarioLogado;
  String _emailUsarioLogado;

  Future<List<Usuario>> _recuperarContatos() async {

    Firestore db = Firestore.instance;

    QuerySnapshot querySnapshot = await db.collection("usuarios")
      .getDocuments();
    
    List<Usuario> listaUsuarios = List();
    for (DocumentSnapshot item in querySnapshot.documents) {

      var dados = item.data;
      if ( dados["email"] ==  _emailUsarioLogado )  continue;

      Usuario usuario = Usuario();
      usuario.email = dados["email"];
      usuario.nome = dados["nome"];
      usuario.urlImagem = dados["urlImagem"];

      listaUsuarios.add(usuario);
    }

    return listaUsuarios;

  }

   _recuperarDadosUsuario() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado =  await auth.currentUser();
    _idUsusarioLogado = usuarioLogado.uid;
    _emailUsarioLogado = usuarioLogado.email;
  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuario();
  }  

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Usuario>>(
      future: _recuperarContatos(),
      builder: (context, snapshot){
        switch(snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Carregando contatos"),
                  CircularProgressIndicator()
                ],
              ),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, indice){

                List<Usuario> listaItens = snapshot.data;
                Usuario usuario = listaItens[indice];
                
                return ListTile(
                  contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                  leading: CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Colors.grey,
                    backgroundImage: 
                    usuario.urlImagem != null
                      ? NetworkImage(usuario.urlImagem)
                      : null
                  ),
                  title: Text(
                    usuario.nome,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  ),
                );
              },
            );
            break;        
        }
      },
    );
  }
}