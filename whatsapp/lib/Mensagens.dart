import 'package:flutter/material.dart';
import 'package:whatsapp/model/Usuario.dart';

class Mensagens extends StatefulWidget {

  Usuario contato;

  Mensagens(this.contato);

  @override
  _MensagensState createState() => _MensagensState();
}

class _MensagensState extends State<Mensagens> {

  TextEditingController _controllerMensagem = TextEditingController();

  _enviarMensagem(){

  }

  _enviarFoto(){
  
  }

  @override
  Widget build(BuildContext context) {

    var caixaMensagem = Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 8),
              child: TextField(
                    controller: _controllerMensagem,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 8, 32, 8),
                      hintText: "Digite uma mensagem...",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(36)
                      ),
                      prefixIcon: IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: _enviarFoto
                      )
                    ),
              ),
            ),
          ),
          FloatingActionButton(
            backgroundColor: Color(0xff075E54),
            child: Icon(Icons.send, color: Colors.white),
            mini: true,
            onPressed: _enviarMensagem,
          )
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text(widget.contato.nome),),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg.png"),
            fit: BoxFit.cover
          )
        ),
        child: SafeArea(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  Text("listview"),
                  caixaMensagem,
                  //listview
                  //caixa mensagem
                ],
              ),
            ),
        ),
      ),
    );
  }
}