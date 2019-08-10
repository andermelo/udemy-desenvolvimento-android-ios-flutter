class Usuario {

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

  Usuario();

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      'nome' : this._nome,
      'email' : this._email
    };

    return map;
  
  }



}