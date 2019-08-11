class Usuario {

  String _idUsuario;

  String get idUsuario => _idUsuario;

  set idUsuario(String idUsuario) {
    _idUsuario = idUsuario;
  }

  String _nome;

  String get nome => _nome;

  set nome(String nome) {
    _nome = nome;
  }

  String _email;

  String get email => _email;

  set email(String email) {
    _email = email;
  }
  
  String _senha;

  String get senha => _senha;

  set senha(String senha) {
    _senha = senha;
  }

  String _urlImagem;

  String get urlImagem => _urlImagem;

  set urlImagem(String urlImagem) {
    _urlImagem = urlImagem;
  }

  Usuario();

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      'nome' : this.nome,
      'email' : this.email
    };

    return map;
  }

}