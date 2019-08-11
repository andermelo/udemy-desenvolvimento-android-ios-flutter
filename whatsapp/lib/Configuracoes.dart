import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Configuracoes extends StatefulWidget {
  @override
  _ConfiguracoesState createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {

  TextEditingController _controllerNome = TextEditingController();
  File _imagem;
  String _idUsusarioLogado;
  bool _subindoImagem = false;
  String _urlImagemRecuperada;

  Future _recuperarImagem(String origemImagem) async{

    File imagemSelicionada;
    switch (origemImagem) {
      case 'camera':
        imagemSelicionada = await ImagePicker.pickImage(source: ImageSource.camera);
        break;
      case 'galeria':
        imagemSelicionada = await ImagePicker.pickImage(source: ImageSource.gallery);
        break;
    }

    setState(() {
     _imagem = imagemSelicionada;
     if ( _imagem != null ) {
       _uploadImagem();
       _subindoImagem = true;
     }
    });
  }

  Future _uploadImagem() async{

    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference pastaRaiz = storage.ref();
    StorageReference arquivo = pastaRaiz
      .child("perfil")
      .child("profile_image_"+ _idUsusarioLogado +".jpg");

    // Upload da imagem
    StorageUploadTask task = arquivo.putFile(_imagem);

    //Controlar progresso do upload
    task.events.listen((StorageTaskEvent storageTaskEvent){
      if ( storageTaskEvent.type == StorageTaskEventType.progress ) {
        setState(() {
          _subindoImagem = true; 
        });
      }else if (storageTaskEvent.type == StorageTaskEventType.success) {
          _subindoImagem = false; 
      }
    });

    //Recuperar url da imagem
    task.onComplete.then((StorageTaskSnapshot snapshot){
      _recuperarUrlImagem(snapshot);
    });

  }

  Future _recuperarUrlImagem(StorageTaskSnapshot snapshot) async{
    String url = await snapshot.ref.getDownloadURL();
    _atualizarUrlImagemFirestore( url );

    setState(() {
     _urlImagemRecuperada = url;
    });
  }

  _atualizarUrlImagemFirestore(String url){

    Firestore db = Firestore.instance;

    Map<String, dynamic> dadosAtualizar = {
      "urlImagem" : url
    };

    db.collection("usuarios")
    .document(_idUsusarioLogado)
    .updateData(dadosAtualizar);
  }

  _atualizarNomeFirestore(String nome){

    // String nome = _controllerNome.text;
    Firestore db = Firestore.instance;

    Map<String, dynamic> dadosAtualizar = {
      "nome" : nome
    };

    db.collection("usuarios")
    .document(_idUsusarioLogado)
    .updateData(dadosAtualizar);
  }

  _recuperarDadosUsuario() async{

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado =  await auth.currentUser();
    _idUsusarioLogado = usuarioLogado.uid;

    Firestore db = Firestore.instance;
    DocumentSnapshot snapshot = await db.collection("usuarios")
      .document(_idUsusarioLogado)
      .get();

    Map<String, dynamic> dados = snapshot.data;
    _controllerNome.text = dados["nome"];

    if (dados["urlImagem"] != null) {
      _urlImagemRecuperada = dados["urlImagem"];
    }

  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text("Configurações de perfil"),),
    body: Container(
      padding: EdgeInsets.all(16),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //Carregando
              Container(
                padding: EdgeInsets.all(16),
                child: _subindoImagem 
                  ? CircularProgressIndicator()
                  : Container(),
              ),
              CircleAvatar(
                radius: 100,
                backgroundColor: Colors.grey,
                backgroundImage: 
                _urlImagemRecuperada !=  null
                  ? NetworkImage(_urlImagemRecuperada)
                  : null
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: Text("Camera"),
                    onPressed: (){
                      _recuperarImagem("camera");
                    },
                  ),
                  FlatButton(
                    child: Text("Galeria"),
                    onPressed: (){
                      _recuperarImagem("galeria");
                    },
                  )
                ],
              ),
              Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: TextField(
                      controller: _controllerNome,
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 20),
                      onChanged: (texto){
                        _atualizarNomeFirestore(texto);
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Nome",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(36)
                        )
                      ),
                    ),
              ),
              Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: RaisedButton(
                        child: Text(
                          "Salvar",
                          style: TextStyle(fontSize:20,color:Colors.white),
                        ),
                        color: Colors.green,
                        padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                        onPressed: (){
                          _atualizarNomeFirestore();
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}