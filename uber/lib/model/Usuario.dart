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
  String _tipoUsuario;

  String get tipoUsuario => _tipoUsuario;

  set tipoUsuario(String tipoUsuario) {
    _tipoUsuario = tipoUsuario;
  }

  double _latitude;

  double get latitude => _latitude;

  set latitude(double latitude) {
    _latitude = latitude;
  }
  double _longitude;

  double get longitude => _longitude;

  set longitude(double longitude) {
    _longitude = longitude;
  }

  Usuario();

  String verificaTipoUsuario(bool tipoUsuario){
    return tipoUsuario ? "motorista" : "passageiro";
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "idUsuario" : this.idUsuario,
      "nome" : this.nome,
      "email" : this.email,
      "tipoUsuario" : this.tipoUsuario,
      "latitude" : this.latitude,
      "longitude" : this.longitude,
    };
    return map;
  }
}