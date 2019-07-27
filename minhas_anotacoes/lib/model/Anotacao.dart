import 'package:minhas_anotacoes/helper/AnotacaoHelper.dart';

class Anotacao {

  int id;
  String titulo;
  String descricao;
  String data;

  Anotacao(this.titulo, this.descricao, this.data);

  Anotacao.fromMap(Map map){

    this.id = map["id"];
    this.titulo = map["titulo"];
    this.descricao = map["descricao"];
    this.data = map["data"];

  }

  Map toMap(){

    Map<String, dynamic> map = {
      "titulo" : this.titulo,
      "descricao" : this.descricao,
      "data" : this.data,
    };

    if(this.id != null){
      map["id"] = this.id;
    }

    return map;
  }
  
}