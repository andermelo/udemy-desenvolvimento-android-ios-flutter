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

  //contrutor
  Conversa(this._nome,this._mensagem,this._caminhoFoto);

}