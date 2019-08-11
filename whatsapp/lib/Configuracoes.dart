import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';


class Configuracoes extends StatefulWidget {
  @override
  _ConfiguracoesState createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {

  TextEditingController _controllerNome = TextEditingController();
  File _imagem;

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
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text("Configurações de perfil"),),
    body: Container(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Column(
          children: <Widget>[
            //Carregando
            CircleAvatar(
              radius: 100,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage("https://firebasestorage.googleapis.com/v0/b/whatsapp-62949.appspot.com/o/perfil%2FC360_2018-05-11-12-37-43-406.jpg?alt=media&token=d39ddd1d-cb59-4087-a53d-721f6be0e803"),
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
                      onPressed: (){},
                    ),
                  ),
          ],
        ),
      ),
    ),
    );
  }
}