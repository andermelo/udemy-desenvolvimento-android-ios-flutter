import 'package:google_maps_flutter/google_maps_flutter.dart';

class Marcador {
  LatLng _local;

  LatLng get local => _local;

  set local(LatLng local) {
    _local = local;
  }
  String _caminhoImagem;

  String get caminhoImagem => _caminhoImagem;

  set caminhoImagem(String caminhoImagem) {
    _caminhoImagem = caminhoImagem;
  }
  String _titulo;

  String get titulo => _titulo;

  set titulo(String titulo) {
    _titulo = titulo;
  }

  Marcador(this._local, this._caminhoImagem, this._titulo);
  
}