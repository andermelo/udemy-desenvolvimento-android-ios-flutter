import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class Corrida extends StatefulWidget {

  String idRequisicao;

  Corrida(this.idRequisicao);

  @override
  _CorridaState createState() => _CorridaState();
}

class _CorridaState extends State<Corrida> {
  
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _posicaoCamera = CameraPosition(
    target: LatLng(-23.563999, -46.653256),
  );
  Set<Marker> _marcadores = {};

  //Controles para exibição na tela
  String _textoBotao = "Aceitar corrida";
  Color _corBotao = Color(0xff1ebbd8);
  Function _funcaoBotao;

  _alterarBotaoPrincipal(String texto, Color cor, Function funcao){
    setState(() {
     _textoBotao = texto;
     _corBotao = cor;
     _funcaoBotao = funcao; 
    });
  }

  _onMapCreated( GoogleMapController controller){
    _controller.complete(controller);
  }

  _adicionarListenerLocalizacao(){

    var geolocator = Geolocator();
    var locationOptions = LocationOptions(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10
    );

    geolocator.getPositionStream(locationOptions).listen((Position position){
      _exibirMarcadorPassageiro(position);
      _posicaoCamera = CameraPosition(
         target: LatLng(position.latitude, position.longitude),
         zoom: 19
       );
       
       _movimentarCamera(_posicaoCamera);

    });

  }

  _recuperarUltimaLocalizacaoConhecida() async{

    Position position = await Geolocator()
      .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
     if (position != null) {
       _exibirMarcadorPassageiro(position);
       _posicaoCamera = CameraPosition(
         target: LatLng(position.latitude, position.longitude),
         zoom: 19
       );
       
       _movimentarCamera(_posicaoCamera);
     } 
    });
  }

  _movimentarCamera(CameraPosition cameraPosition) async {

    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        cameraPosition
      )
    );
  }

  _exibirMarcadorPassageiro(Position local) async {

    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: pixelRatio), 
        "images/motorista.png"
    ).then((BitmapDescriptor icone){

      Marker marcadorPassageiro = Marker(
        markerId: MarkerId("marcador-motorista"),
        position: LatLng(local.latitude, local.longitude),
        infoWindow: InfoWindow(
          title: "Meu local"
        ),
        icon:  icone
      );

      setState(() {
        _marcadores.add(marcadorPassageiro); 
      });

    });
  }

  @override
  void initState() {
    super.initState();
    _recuperarUltimaLocalizacaoConhecida();
    _adicionarListenerLocalizacao();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Painel corrida"),
      ),      
      body: Container(
        child: Stack(
          children: <Widget>[
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _posicaoCamera,
              onMapCreated: _onMapCreated,
              // myLocationEnabled: true,
              markers: _marcadores,
              myLocationButtonEnabled: false, //retirar botao de encontrar minha localização
              // -23.609323, -46.768152
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: Padding(
                padding: Platform.isIOS
                ? EdgeInsets.fromLTRB(20, 10, 20, 25)
                : EdgeInsets.all(10),
                child: RaisedButton(
                    child: Text(_textoBotao.toUpperCase(), 

                      style: TextStyle(color: Colors.white,fontSize: 20),
                    ),
                    color: _corBotao,
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    onPressed: _funcaoBotao,
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
}