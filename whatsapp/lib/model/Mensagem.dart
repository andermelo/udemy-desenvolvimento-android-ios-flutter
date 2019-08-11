class Mensagem {

  Mensagem();

  String _idUsuario;

  String get idUsuario => _idUsuario;

  set idUsuario(String idUsuario) {
    _idUsuario = idUsuario;
  }
  String _mensagem;

  String get mensagem => _mensagem;

  set mensagem(String mensagem) {
    _mensagem = mensagem;
  }
  String _urlImagem;

  String get urlImagem => _urlImagem;

  set urlImagem(String urlImagem) {
    _urlImagem = urlImagem;
  }
  String _tipo;

  String get tipo => _tipo;

  set tipo(String tipo) {
    _tipo = tipo;
  }

  Map<String, dynamic> toMap(){
    
    Map<String, dynamic> map = {
      'idUsuario' : this.idUsuario,
      'mensagem' : this.mensagem,
      'urlImagem' : this.urlImagem,
      'tipo' : this.tipo,
    };

    return map;
  
  }

}