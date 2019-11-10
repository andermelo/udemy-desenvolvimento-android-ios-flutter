import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'dart:io';
import 'package:uber/model/Destino.dart';
import 'package:uber/model/Marcador.dart';
import 'package:uber/model/Requisicao.dart';
import 'package:uber/model/Usuario.dart';
import 'package:uber/util/StatusRequisicao.dart';
import 'package:uber/util/UsuarioFirebase.dart';

class PainelPassageiro extends StatefulWidget {
  @override
  _PainelPassageiroState createState() => _PainelPassageiroState();
}

class _PainelPassageiroState extends State<PainelPassageiro> {

  TextEditingController _controllerDestino = TextEditingController(text: "Av. Paulista, 807");
  List<String> itensMenu = ["Configurações", "Sair"];
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _posicaoCamera = CameraPosition(
    target: LatLng(-23.563999, -46.653256),
  );
  Set<Marker> _marcadores = {};
  String _idRequisicao;
  Position _localPassageiro;
  Map<String, dynamic> _dadosRequisicao;
  StreamSubscription<DocumentSnapshot> _streamSubscriptionRequisicoes;

  //Controles para exibição na tela
  bool _exibirCaixaEnderecoDestino = true;
  String _textoBotao = "Chamar Uber";
  Color _corBotao = Color(0xff1ebbd8);
  Function _funcaoBotao;

  _deslogarUsuario() async{

    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.signOut();
    Navigator.pushReplacementNamed(context, "/");

  }

  _escolhaMenuItem(String escolha){
    switch (escolha) {
      case "Sair":
        _deslogarUsuario();
        break;
    }
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

      if (_idRequisicao != null && _idRequisicao.isNotEmpty ) {
        
        //Atualiza local do passageiro
        UsuarioFirebase.atualizarDadosLocalizacao(
          _idRequisicao, 
          position.latitude,
          position.longitude
        );
      }else{
        setState(() {
         _localPassageiro = position;  
        });
        _statusUberNaoChamado();
      }
    });
  }

  _recuperarUltimaLocalizacaoConhecida() async{

    Position position = await Geolocator()
      .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
     if (position != null) {
       
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
        "images/passageiro.png"
    ).then((BitmapDescriptor icone){

      Marker marcadorPassageiro = Marker(
        markerId: MarkerId("marcador-passageiro"),
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

  _chamarUber() async{

    String enderecoDestino = _controllerDestino.text;

    if (enderecoDestino.isNotEmpty) {
      
      List<Placemark> listaEnderecos = await Geolocator()
        .placemarkFromAddress( enderecoDestino );
      if (listaEnderecos.isNotEmpty && listaEnderecos.length > 0) {
        Placemark endereco = listaEnderecos[0];
        Destino destino = Destino();
        destino.cidade = endereco.administrativeArea;
        destino.cep = endereco.postalCode;
        destino.bairro = endereco.subLocality;
        destino.rua = endereco.thoroughfare;
        destino.numero = endereco.subThoroughfare;
        destino.latitude = endereco.position.latitude;
        destino.longitude = endereco.position.longitude;

        String enderecoConfirmacao;
        enderecoConfirmacao = "\n Cidade: " + destino.cidade;
        enderecoConfirmacao += "\n Rua: " + destino.rua + ", " + destino.numero;
        enderecoConfirmacao += "\n Bairro: " + destino.bairro ;
        enderecoConfirmacao += "\n Cep: " + destino.cep ;

        showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text("Confirmação do endereço"),
              content: Text(enderecoConfirmacao),
              contentPadding: EdgeInsets.all(16),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar", style: TextStyle(color: Colors.red),),
                  onPressed: ()=> Navigator.pop(context),
                ),
                FlatButton(
                  child: Text("Confirmar", style: TextStyle(color: Colors.green),),
                  onPressed: (){

                    _salvarRequisicao(destino);

                    Navigator.pop(context);
                  },
                )
              ],
            );
          }
        );
      }
    } 
  }

  _salvarRequisicao(Destino destino) async {
    /*
    + requisicao
      + ID_REQUISICAO
        + destino (rua, endereco, latitude...)
        + passageiro (nome, email...)
        + motorista (nome, email...)
        + status (aguardando, a_caminho...finalizado)
    */

    Usuario passageiro   = await UsuarioFirebase.getDadosUsuarioLogado();
    passageiro.latitude  = _localPassageiro.latitude;
    passageiro.longitude = _localPassageiro.longitude;

    Requisicao requisicao = Requisicao();
    requisicao.destino = destino;
    requisicao.passageiro = passageiro;
    requisicao.status = StatusRequisicao.AGUARDANDO;

    Firestore db = Firestore.instance;

    //salvar requisicao
    db.collection("requisicoes")
      .document(requisicao.id)
      .setData(requisicao.toMap());

    //salvar requisicao ativa
    Map<String, dynamic> dadosRequisicaoAtiva = {};
    dadosRequisicaoAtiva["id_requisicao"] = requisicao.id;
    dadosRequisicaoAtiva["id_usuario"] = passageiro.idUsuario;
    dadosRequisicaoAtiva["status"] = StatusRequisicao.AGUARDANDO;


    db.collection("requisicao_ativa")
      .document(passageiro.idUsuario)
      .setData(dadosRequisicaoAtiva);

    //chama método para alterar interface para status aguardando
    _statusAguardando();

    //Adicionar listener requisicao
    if (_streamSubscriptionRequisicoes == null) {
      _adicionarListenerRequisicao(requisicao.id);
    }
    

  }

  _alterarBotaoPrincipal(String texto, Color cor, Function funcao){
    setState(() {
     _textoBotao = texto;
     _corBotao = cor;
     _funcaoBotao = funcao; 
    });
  }

  _statusUberNaoChamado(){
    _exibirCaixaEnderecoDestino = true;

    _alterarBotaoPrincipal("Chamar Uber",Color(0xff1ebbd8), (){
      _chamarUber();
    });

    if ( _localPassageiro != null) {
      Position position = Position(
        latitude: _localPassageiro.latitude,
        longitude: _localPassageiro.longitude
      );
      _exibirMarcadorPassageiro(position);
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),zoom: 19);             
      _movimentarCamera(cameraPosition);
    }
    
  }

  _statusAguardando(){
    _exibirCaixaEnderecoDestino = false;
    _alterarBotaoPrincipal(
      "Cancelar", 
      Colors.red, 
      (){
        _cancelarUber();
      }    
    );

    double passageiroLat = _dadosRequisicao["passageiro"]["latitude"];
    double passageiroLon = _dadosRequisicao["passageiro"]["longitude"];
    Position position = Position(
      latitude: passageiroLat,
      longitude: passageiroLon
    );
    _exibirMarcadorPassageiro(position);
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),zoom: 19);             
    _movimentarCamera(cameraPosition);
  }

  _statusACaminho(){

    _exibirCaixaEnderecoDestino = false;
    _alterarBotaoPrincipal(
      "Motorista a caminho", 
      Colors.grey, 
      (){
    });

    
    double latitudeDestino = _dadosRequisicao["passageiro"]["latitude"];
    double longitudeDestino = _dadosRequisicao["passageiro"]["longitude"];

    double latitudeOrigem = _dadosRequisicao["motorista"]["latitude"];
    double longitudeOrigem = _dadosRequisicao["motorista"]["longitude"];

    Marcador marcadorOrigem = Marcador(
      LatLng(latitudeOrigem, longitudeOrigem), 
      "images/motorista.png", 
      "Local motorista"
    );

    Marcador marcadorDestino = Marcador(
      LatLng(latitudeDestino, longitudeDestino), 
      "images/passageiro.png", 
      "Local passageiro"
    );

    _exibirCentralizarDoisMarcadores(marcadorOrigem, marcadorDestino);

  }

   _statusEmViagem(){
    
    _exibirCaixaEnderecoDestino = false;
    _alterarBotaoPrincipal(
      "Em viagem", 
      Colors.grey, 
      null   
    );

    double latitudeDestino = _dadosRequisicao["destino"]["latitude"];
    double longitudeDestino = _dadosRequisicao["destino"]["longitude"];

    double latitudeOrigem = _dadosRequisicao["motorista"]["latitude"];
    double longitudeOrigem = _dadosRequisicao["motorista"]["longitude"];

    Marcador marcadorOrigem = Marcador(
      LatLng(latitudeOrigem, longitudeOrigem), 
      "images/motorista.png", 
      "Local motorista"
    );

    Marcador marcadorDestino = Marcador(
      LatLng(latitudeDestino, longitudeDestino), 
      "images/destino.png", 
      "Local Destino"
    );

    _exibirCentralizarDoisMarcadores(marcadorOrigem, marcadorDestino);
    

  }

  _exibirCentralizarDoisMarcadores(Marcador marcadorOrigem, Marcador marcadorDestino){

    double latitudeOrigem = marcadorOrigem.local.latitude;
    double longitudeOrigem = marcadorOrigem.local.longitude;

    double latitudeDestino = marcadorDestino.local.latitude;
    double longitudeDestino = marcadorDestino.local.longitude;

    _exibirDoisMarcadores(
      marcadorOrigem,
      marcadorDestino
    );

    var nLat, nLon, sLat, sLon;
    if (latitudeOrigem <= latitudeDestino) {
      sLat = latitudeOrigem;
      nLat = latitudeDestino;
    }else{
      sLat = latitudeDestino;
      nLat = latitudeOrigem;
    }

    if (latitudeOrigem <= longitudeDestino) {
      sLon = longitudeOrigem;
      nLon = longitudeDestino;
    }else{
      sLon = longitudeDestino;
      nLon = longitudeOrigem;
    }

    _movimentarCameraBounds(
      LatLngBounds(
        northeast: LatLng(nLat, nLon),  //nordeste
        southwest: LatLng(sLat, sLon)   //sudoeste
      )
      
    );

  }


  _exibirDoisMarcadores( Marcador marcadorOrigem, Marcador marcadorDestino ){

    double pixelRatio = MediaQuery.of(context).devicePixelRatio;

    LatLng latLngOrigem = marcadorOrigem.local;
    LatLng latLngDestino = marcadorDestino.local;

    Set<Marker> _listaMarcadores = {};
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: pixelRatio), 
        marcadorOrigem.caminhoImagem
    ).then((BitmapDescriptor icone){
      Marker mOrigem = Marker(
        markerId: MarkerId(marcadorOrigem.caminhoImagem),
        position: LatLng(latLngOrigem.latitude, latLngOrigem.longitude),
        infoWindow: InfoWindow(
          title: marcadorOrigem.titulo
        ),
        icon:  icone
      );
      _listaMarcadores.add(mOrigem);
    });

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: pixelRatio), 
        marcadorDestino.caminhoImagem
    ).then((BitmapDescriptor icone){
      Marker mDestino = Marker(
        markerId: MarkerId(marcadorDestino.caminhoImagem),
        position: LatLng(latLngDestino.latitude, latLngDestino.longitude),
        infoWindow: InfoWindow(
          title: marcadorDestino.titulo
        ),
        icon:  icone
      );
      _listaMarcadores.add(mDestino);
    });

    setState(() {
     _marcadores = _listaMarcadores;
    //  _movimentarCamera(CameraPosition(
    //    target:LatLng(latLngMotorista.latitude, latLngMotorista.longitude),
    //    zoom: 18
    //   ));
    });

  }

  _movimentarCameraBounds(LatLngBounds latLngBounds) async {

    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(
      CameraUpdate.newLatLngBounds(
        latLngBounds, 
        100
      )
    );
  }

  _cancelarUber() async{
    FirebaseUser firebaseUser = await UsuarioFirebase.getUsuarioAtual();
    Firestore db = Firestore.instance;
    db.collection("requisicoes")
      .document(_idRequisicao).updateData({
        "status" : StatusRequisicao.CANCELADA
      }).then((_){
        db.collection("requisicao_ativa")
          .document(firebaseUser.uid)
          .delete();
      });    
  }

  _recuperarRequisicaoAtiva() async{
    FirebaseUser firebaseUser = await UsuarioFirebase.getUsuarioAtual();

    Firestore db = Firestore.instance;
    DocumentSnapshot documentSnapshot = await db.collection("requisicao_ativa")
            .document(firebaseUser.uid)
            .get();
    
    if (documentSnapshot.data != null) {

      Map<String, dynamic> dados = documentSnapshot.data;
      _idRequisicao = dados["id_requisicao"];
      _adicionarListenerRequisicao( _idRequisicao );
    }else{
      _statusUberNaoChamado();
    }

  }

  

  _adicionarListenerRequisicao(String idRequisicao) async{

    Firestore db = Firestore.instance;
    _streamSubscriptionRequisicoes = await db.collection("requisicoes")
            .document(idRequisicao).snapshots().listen((snapshot){
              if (snapshot.data != null) {
                Map<String,dynamic> dados = snapshot.data;
                _dadosRequisicao = dados;
                String status = dados["status"];
                _idRequisicao = dados["id_requisicao"];

                switch (status) {
                  case StatusRequisicao.AGUARDANDO:
                    _statusAguardando();
                    break;
                  case StatusRequisicao.A_CAMINHO:
                    _statusACaminho();
                    break;
                  case StatusRequisicao.VIAGEM:
                    _statusEmViagem();
                    break;
                  case StatusRequisicao.FINALIZADA:
                    
                    break;
                }
              }
            });
  }

  @override
  void initState() {
    super.initState();

    //adicionar listener para requisicao ativa
    _recuperarRequisicaoAtiva();

    // _recuperarUltimaLocalizacaoConhecida();
    _adicionarListenerLocalizacao();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Painel passageiro"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _escolhaMenuItem,
            itemBuilder: (context){

              return itensMenu.map((String item){

                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );

              }).toList();

            },
          )
        ],
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
              // -23.608463, -46.767734
              // -23.608089, -46.768206
            ),
            Visibility(
              visible: _exibirCaixaEnderecoDestino,
              child: Stack(
                children: <Widget>[
                  Positioned(
                  top: 0,
                  left: 0,
                  right:0,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.white
                      ),
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          icon: Container(
                            margin: EdgeInsets.only(left: 20),
                            width: 10,
                            height: 10,
                            child: Icon(Icons.location_on, color: Colors.green,),
                          ),
                          hintText: "Meu local",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 15,top: 16)
                        ),
                      ),
                    ),
                  ),
                ),            
                Positioned(
                  top: 55,
                  left: 0,
                  right:0,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.white
                      ),
                      child: TextField(
                        controller: _controllerDestino,
                        decoration: InputDecoration(
                          icon: Container(
                            margin: EdgeInsets.only(left: 20),
                            width: 10,
                            height: 10,
                            child: Icon(Icons.local_taxi, color: Colors.grey,),
                          ),
                          hintText: "Digite seu destino",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 15,top: 16)
                        ),
                      ),
                    ),
                  ),
                )
                ],
              ),
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

  @override
  void dispose() {
    super.dispose();
    _streamSubscriptionRequisicoes.cancel();
  }

}