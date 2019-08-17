import 'package:cloud_firestore/cloud_firestore.dart';

class Conversa {
  String _nome;

  String get nome => _nome;

  set nome(String nome) {
    _nome = nome;
  }

  String _mensagem;

  String get mensagem => _mensagem;

  set mensagem(String mensagem) {
    _mensagem = mensagem;
  }

  String _caminhoFoto;

  String get caminhoFoto => _caminhoFoto;

  set caminhoFoto(String caminhoFoto) {
    _caminhoFoto = caminhoFoto;
  }

  String _idRemetente;

  String get idRemetente => _idRemetente;

  set idRemetente(String idRemetente) {
    _idRemetente = idRemetente;
  }

  String _idDestinatario;

  String get idDestinatario => _idDestinatario;

  set idDestinatario(String idDestinatario) {
    _idDestinatario = idDestinatario;
  }

  String _tipoMensagem;

  String get tipoMensagem => _tipoMensagem;

  set tipoMensagem(String tipoMensagem) {
    _tipoMensagem = tipoMensagem;
  }

  //contrutor
  Conversa();

  salvar() async{
    
    /*
      + conversas
        + anderson
          + pedro
            + ultima_conversa
              + pedro
              idRemetente
              idDestinatario
    */

    Firestore db = Firestore.instance;
    await db.collection("conversas")
          .document( this.idRemetente )
          .collection( "ultima_conversa" )
          .document( this.idDestinatario )
          .setData(this.toMap() );

  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      'idRemetente'     : this.idRemetente,
      'idDestinatario'  : this.idDestinatario,
      'nome'            : this.nome,
      'mensagem'        : this.mensagem,
      'caminhoFoto'     : this.caminhoFoto,      
      'tipoMensagem'    : this.tipoMensagem,
    };

    return map;
  }

}