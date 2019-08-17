import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/model/Conversa.dart';
import 'package:whatsapp/model/Mensagem.dart';
import 'package:whatsapp/model/Usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


class Mensagens extends StatefulWidget {

  Usuario contato;
  Mensagens(this.contato);

  @override
  _MensagensState createState() => _MensagensState();
}

class _MensagensState extends State<Mensagens> {

  File _imagem;
  bool _subindoImagem = false;
  String _idUsusarioLogado;
  String _idUsusarioDestinario;
  Firestore db = Firestore.instance;
  TextEditingController _controllerMensagem = TextEditingController();

  final _controller = StreamController<QuerySnapshot>.broadcast();
  ScrollController _scrollController = ScrollController();

  _enviarMensagem(){

    String textoMensagem = _controllerMensagem.text;
    if (textoMensagem.isNotEmpty) {
      
      Mensagem mensagem = Mensagem();
      mensagem.idUsuario = _idUsusarioLogado;
      mensagem.mensagem = textoMensagem;
      mensagem.urlImagem = "";
      mensagem.tipo = "texto";

      //Salvar mensagem para remetente
      _salvarMensagem(_idUsusarioLogado, _idUsusarioDestinario, mensagem);

      //Salvar mensagem para remetente
      _salvarMensagem(_idUsusarioDestinario, _idUsusarioLogado, mensagem);

      //salvar conversa
      _salvarConversa( mensagem );

    }
  }

  _salvarConversa(Mensagem msg){

    //Salvar conversa remetente
    Conversa cRemetente = Conversa();
    cRemetente.idRemetente = _idUsusarioLogado;
    cRemetente.idDestinatario = _idUsusarioDestinario;
    cRemetente.mensagem = msg.mensagem;
    cRemetente.nome = widget.contato.nome;
    cRemetente.caminhoFoto = widget.contato.urlImagem;
    cRemetente.tipoMensagem = msg.tipo;
    cRemetente.salvar();

    //Salvar conversa destinatario
    Conversa cDestinatario = Conversa();
    cDestinatario.idRemetente = _idUsusarioDestinario;
    cDestinatario.idDestinatario = _idUsusarioLogado;
    cDestinatario.mensagem = msg.mensagem;
    cDestinatario.nome = widget.contato.nome;
    cDestinatario.caminhoFoto = widget.contato.urlImagem;
    cDestinatario.tipoMensagem = msg.tipo;
    cDestinatario.salvar();

  }

  _salvarMensagem(String idRemetente, String idDestinatario, Mensagem msg) async{

    await db.collection("mensagens")
      .document(idRemetente)
      .collection(idDestinatario)
      .add( msg.toMap() );

      //Limpar mensagem
      _controllerMensagem.clear();

    /*
    + mensagens
      + anderson melo
        + contato
          + identificadorFirebase
            <Mensagme>
    */

  }

  _enviarFoto() async{
    
    File imagemSelicionada;
    imagemSelicionada = await ImagePicker.pickImage(source: ImageSource.gallery);

    String nomeImagem = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference pastaRaiz = storage.ref();
    StorageReference arquivo = pastaRaiz
      .child("mensagens")
      .child( _idUsusarioLogado )
      .child(nomeImagem +".jpg");

    // Upload da imagem
    StorageUploadTask task = arquivo.putFile(imagemSelicionada);

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

    Mensagem mensagem = Mensagem();
    mensagem.idUsuario = _idUsusarioLogado;
    mensagem.mensagem = "";
    mensagem.urlImagem = url;
    mensagem.tipo = "imagem";

    //Salvar mensagem para remetente
    _salvarMensagem(_idUsusarioLogado, _idUsusarioDestinario, mensagem);

    //Salvar mensagem para remetente
    _salvarMensagem(_idUsusarioDestinario, _idUsusarioLogado, mensagem);
  }

  _inicializarDados() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado =  await auth.currentUser();
    _idUsusarioLogado = usuarioLogado.uid;
    _idUsusarioDestinario = widget.contato.idUsuario;
    _adicionarListenerMensagens();
  }

  @override
  void initState() {
    super.initState();
    _inicializarDados();
  }

  Stream<QuerySnapshot> _adicionarListenerMensagens(){

    final Stream = db.collection("mensagens")
        .document( _idUsusarioLogado )
        .collection( _idUsusarioDestinario)
        .snapshots();

    Stream.listen((dados){
      _controller.add( dados );
      Timer(Duration(seconds: 1), (){
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      } );
    });
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
                      prefixIcon:
                        _subindoImagem
                          ? CircularProgressIndicator() 
                          : IconButton(icon: Icon(Icons.camera_alt),onPressed: _enviarFoto),
                    ),
              ),
            ),
          ),
          Platform.isIOS 
          ? CupertinoButton(
              child: Text("Envir"),
              onPressed: _enviarMensagem(),
            )
          : FloatingActionButton(
              backgroundColor: Color(0xff075E54),
              child: Icon(Icons.send, color: Colors.white),
              mini: true,
              onPressed: _enviarMensagem,
            ) 
        ],
      ),
    );

    var stream = StreamBuilder(
      stream: _controller.stream,
      builder: (context, snapshot){
        switch(snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Carregando mensagens"),
                  CircularProgressIndicator()
                ],
              ),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:

            QuerySnapshot querySnapshot =  snapshot.data;

            if ( snapshot.hasError ){
              return Text("Erro ao carregar os dados");
            }else{
              return Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: querySnapshot.documents.length,
                  itemBuilder: (context, indice){

                    //recuperar mensagem
                    List<DocumentSnapshot> mensagens = querySnapshot.documents.toList();
                    DocumentSnapshot item = mensagens[indice];

                    double larguraContainer = MediaQuery.of(context).size.width * 0.8;

                    //Define cores e alinhamentos
                    Alignment alinhamento = Alignment.centerRight;
                    Color cor = Color(0xffd2ffa5);

                    if(_idUsusarioLogado != item["idUsuario"]){
                      alinhamento = Alignment.centerLeft;
                      cor = Color(0xfffafafa);
                    }

                    return Align(
                      alignment: alinhamento,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Container(
                          width: larguraContainer,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: cor,
                            borderRadius: BorderRadius.all(Radius.circular(8))
                          ),
                          child: 
                            item["tipo"] == ["texto"] 
                            ? Text(item["mensagem"],style: TextStyle(fontSize: 18, color: Colors.black),)
                            : Image.network(item["urlImagem"]),
                        ),
                      ),
                    );

                  },
                ),
              );
            }            
            break;
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            CircleAvatar(
              maxRadius: 20,
              backgroundColor: Colors.grey,
              backgroundImage: widget.contato.urlImagem != null
              ? NetworkImage(widget.contato.urlImagem)
              : null
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(widget.contato.nome),
            )
          ],
        ),
      ),
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
                  //listview
                  stream,
                  //caixa mensagem
                  caixaMensagem,
                ],
              ),
            ),
        ),
      ),
    );
  }
}