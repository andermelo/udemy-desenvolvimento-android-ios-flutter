import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  db.collection("usuarios").snapshots().listen(
    ( snapshot ){
      for( DocumentSnapshot item in snapshot.documents){
        var dados = item.data;
        print("dados usuarios: " + dados["nome"] + " - " + dados["idade"].toString() );
      }
    }
  );

  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}