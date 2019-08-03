import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

void main() async{

  Firestore db = Firestore.instance;

  // db.collection("usuarios")
  //   .document("001")
  //   .setData(
  //       {
  //         "nome" : "Anderson Melo",
  //         "idade" : "29"
  //       }
  //   );

  // DocumentReference ref = await db.collection("noticias")
  // .add( // utilzando o add é gerado um identificador automatico
  //   {
  //     "titulo" : "Frio extremo nesse final de semana :s",
  //     "descricao" : "texto de exemplo..."
  //   }
  // );

  // print("item salvo: " + ref.documentID);

  // db.collection("noticias")
  // .document("u8RDZLSiVB0ttsftA0P6")
  // .setData(
  //   {
  //     "titulo" : "Frio extremo nesse final de semana :s -editado às 13:42",
  //     "descricao" : "Ta frioooooo!"
  //   }
  // );

  // excluir
  // db.collection("usuarios").document("003").delete();

  // recuperar item
  // DocumentSnapshot snapshot = await db.collection("usuarios")
  //   .document("002")
  //   .get();

  // print("dados: " + snapshot.data.toString());

  // var dados = snapshot.data;

  // print("nome: " + dados["nome"] + " idade: " + dados["idade"]);


  // recuperar todos documentos para uma coleção
  // QuerySnapshot querySnapshot = await db
  // .collection("usuarios")
  // .getDocuments();

  // print("dados usuarios: " + querySnapshot.documents.toString() );

  // for( DocumentSnapshot item in querySnapshot.documents){
  //   var dados = item.data;
  //   print("dados usuarios: " + dados["nome"] + " - " + dados["idade"].toString() );
  // }

  // recuperando dados recebendo atualizações com .listen (ouvinte)
  // db.collection("usuarios").snapshots().listen(
  //   ( snapshot ){
  //     for( DocumentSnapshot item in snapshot.documents){
  //       var dados = item.data;
  //       print("dados usuarios: " + dados["nome"] + " - " + dados["idade"].toString() );
  //     }
  //   }
  // );

  var pesquisa = "pe";

  // filtros
  QuerySnapshot querySnapshot =  await db.collection("usuarios")
  // // .where("nome", isEqualTo: "pedro melo")
  // // .where("idade", isEqualTo: 45)
  // .where("idade", isLessThan: 46)
  // .orderBy("idade", descending: true)
  // .orderBy("nome", descending: false)
  // .limit(2)
  // .getDocuments();
  
  // buscar texto
  .where("nome", isGreaterThanOrEqualTo: pesquisa)
  .where("nome", isLessThanOrEqualTo: pesquisa + "\uf8ff")
  .getDocuments();


  for (DocumentSnapshot item in querySnapshot.documents) {
    var dados = item.data;
    print("filtro nome: ${dados["nome"]} idade: ${dados["idade"]}");    
  }
  
  // Cadastro e verificação de usuário logado
  FirebaseAuth auth = await FirebaseAuth.instance;  


  // Criando um usuario com email e senha
  // String email = "anderson.90@gmail.com";
  // String senha = "123456";

  // auth.createUserWithEmailAndPassword(
  //   email: email, 
  //   password: senha)
  // .then((firebaseUser){
  //     print("deu certo - " + firebaseUser.user.email );
  // }).catchError((erro){
  //     print("novo usuario: erro " + erro.toString());
  // });

  // auth.signOut(); //deslogar

  // auth.signInWithEmailAndPassword(
  //   email: "anderson.90@gmail.com",
  //   password: "123456")
  //   .then((firebaseUser){
  //     print("usuário logado com sucesso! email: " + firebaseUser.user.email );
  //   }).catchError((erro){
  //     print("erro no login - " + erro.toString());
  //   });

  FirebaseUser usuarioAtual = await auth.currentUser();
  if (usuarioAtual != null) { //logado
    print("usuario atual logado email: " + usuarioAtual.email );
  }else{//deslogado
    print("Usuário atual está DESLOGADO!");
  }


  runApp(
    MaterialApp(
      home: Home(),
    )
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  File _image;
  String _statusUpload = "Upload nao iniciado";
  String _urlImagemRecuperada = null;

  Future _recuperarImagem(bool daCamera) async {
    File imagemSelecionada;
    
    if (daCamera) { //camera
      imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.camera);
    }else{//galeria
      imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      _image = imagemSelecionada; 
    });

  }

  Future _uploadImagem() async {
    // Referenciar Imagem
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference pastaRaiz = storage.ref();
    StorageReference arquivo = pastaRaiz
      .child("fotos")
      .child("foto1.jpg");

    // Fazer upload da imagem
    StorageUploadTask task = arquivo.putFile(_image);

    //Controlar progresso do upload
    task.events.listen((StorageTaskEvent storageEvent){

      if (storageEvent.type == StorageTaskEventType.progress){
        setState(() {
         _statusUpload = "Upload em andamento!"; 
        });
      } else if( storageEvent.type == StorageTaskEventType.success) {
        setState(() {
         _statusUpload = "upload feito com sucesso"; 
        });
      }

    });

    task.onComplete.then((StorageTaskSnapshot snapshot){

      _recuperarUrlImagem( snapshot );

    });
  }

  Future _recuperarUrlImagem(StorageTaskSnapshot snapshot) async {

      String url = await snapshot.ref.getDownloadURL();
      print("URL: " + url);

      setState(() {
       _urlImagemRecuperada = url; 
      });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selecionar imagem"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(_statusUpload),
            RaisedButton(
              child: Text("Camera"),
              onPressed: (){
                _recuperarImagem(true);
              },
            ),
            RaisedButton(
              child: Text("Galeria"),
              onPressed: (){
                _recuperarImagem(false);
              },
            ),
            _image == null ? Container() : Image.file( _image ),

            _image == null ? Container() :
            RaisedButton(
              child: Text("Upload imagem - Storage"),
              onPressed: (){
                _uploadImagem();
              },
            ),
            _urlImagemRecuperada == null 
            ? Container()
            : Image.network( _urlImagemRecuperada ) 
          ],
        ),
      ),
    );
  }
}