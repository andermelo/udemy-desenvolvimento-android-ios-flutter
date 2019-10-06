import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber/model/Destino.dart';
import 'package:uber/model/Usuario.dart';

class Requisicao {

  String _id;

  String get id => _id;

  set id(String id) {
    _id = id;
  }
  String _status;

  String get status => _status;

  set status(String status) {
    _status = status;
  }
  Usuario _passageiro;

  Usuario get passageiro => _passageiro;

  set passageiro(Usuario passageiro) {
    _passageiro = passageiro;
  }
  Usuario _mototorista;

  Usuario get mototorista => _mototorista;

  set mototorista(Usuario mototorista) {
    _mototorista = mototorista;
  }
  Destino _destino;

  Destino get destino => _destino;

  set destino(Destino destino) {
    _destino = destino;
  }

  Requisicao(){
    Firestore db = Firestore.instance;
    DocumentReference ref = db.collection("requisicoes").document();
    this.id = ref.documentID;
  }

  Map<String, dynamic> toMap(){

    Map<String, dynamic> dadosPassageiro = {
      "idUsuario" : this.passageiro.idUsuario,
      "nome" : this.passageiro.nome,
      "email" : this.passageiro.email,
      "tipoUsuario" : this.passageiro.tipoUsuario,
      "longitude" : this.passageiro.longitude,
      "latitude" : this.passageiro.latitude,
    };

    Map<String, dynamic> dadosDestino = {
      "rua" : this.destino.rua,
      "numero" : this.destino.numero,
      "bairro" : this.destino.bairro,
      "cep" : this.destino.cep,
      "latitude" : this.destino.latitude,
      "longitude" : this.destino.longitude,
    };

    Map<String, dynamic> dadosRequisicao = {
      "id" : this.id,
      "status" : this.status,
      "passageiro" : dadosPassageiro,
      "motorista" : null,
      "destino" :dadosDestino,
    };
    
    return dadosRequisicao;
  }

}