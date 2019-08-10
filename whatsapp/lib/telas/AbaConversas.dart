import 'package:flutter/material.dart';
import 'package:whatsapp/model/Conversa.dart';

class AbaConversas extends StatefulWidget {
  @override
  _AbaConversasState createState() => _AbaConversasState();
}

class _AbaConversasState extends State<AbaConversas> {

  List<Conversa> listaConversas = [
    Conversa(
      "Ana Clara",
      "Olá, tudo bem?",
      "https://firebasestorage.googleapis.com/v0/b/whatsapp-62949.appspot.com/o/perfil%2Fperfil1.jpg?alt=media&token=52f5ce07-855c-40b6-b422-4ef6eb40c5ca"
    ),
    Conversa(
      "João Maria",
      "Hey, fdp não!",
      "https://firebasestorage.googleapis.com/v0/b/whatsapp-62949.appspot.com/o/perfil%2Fperfil2.jpg?alt=media&token=af76bbbc-a99e-41f7-8df1-b605ce9d27df"
    ),
    Conversa(
      "Luana",
      "Pega o beco!",
      "https://firebasestorage.googleapis.com/v0/b/whatsapp-62949.appspot.com/o/perfil%2Fperfil3.jpg?alt=media&token=ac279383-df63-496e-8631-ca3d955e5904"
    ),
    Conversa(
      "Robson Lopes",
      "Olá, tudo bem?",
      "https://firebasestorage.googleapis.com/v0/b/whatsapp-62949.appspot.com/o/perfil%2Fperfil4.jpg?alt=media&token=e1cc11a5-681e-49e3-9b3f-571316fc56f7"
    ),
    Conversa(
      "Anderson Melo",
      "Ahhh! ta de uninho!",
      "https://firebasestorage.googleapis.com/v0/b/whatsapp-62949.appspot.com/o/perfil%2FC360_2018-05-11-12-37-43-406.jpg?alt=media&token=d39ddd1d-cb59-4087-a53d-721f6be0e803"
    ),
  ];
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listaConversas.length,
      itemBuilder: (context, indice){
        Conversa conversa = listaConversas[indice];
        return ListTile(
          contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 16),
          leading: CircleAvatar(
            maxRadius: 30,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage( conversa.caminhoFoto ),
          ),
          title: Text(
            conversa.nome,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
          ),
          subtitle: Text(
            conversa.mensagem,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14
            ),
          ),
        );
      },
    );
  }
}