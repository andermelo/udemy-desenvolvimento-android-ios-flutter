import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Completer<GoogleMapController> _completer = Completer();
  CameraPosition _posicaoCamera = CameraPosition(
    target: LatLng(-23.6095678,-46.7699542),
    zoom: 17
  );

  Set<Marker> _marcadores = {};
  Set<Polygon> _polygons = {};
  Set<Polyline> _polylines = {};

  _onMapCreated( GoogleMapController googleMapController ){
    _completer.complete(googleMapController);
  }

  _movimentarCamera() async{
    GoogleMapController googleMapController = await _completer.future;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        // CameraPosition(
        //   target: LatLng(-23.6093853,-46.7706047),
        //   zoom: 20,
        //   tilt: 0,
        //   bearing: 170
        // )
        _posicaoCamera
      )
    );
  }

  _carregarMarcadores(){

    /*
    Set<Marker> marcadoresLocal= {};

    Marker marcadorShopping = Marker(
      markerId: MarkerId("marcador-shopping"),
      position: LatLng(-23.6095678,-46.7699542),
      infoWindow: InfoWindow(
        title: "Taboão Plaza Outlet"
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueGreen
      ),
      onTap: (){
        print("Shopping clicado");
      }
    );

    Marker marcadorBurger = Marker(
      markerId: MarkerId("marcador-burger"),
      position: LatLng(-23.609618, -46.768841),
      infoWindow: InfoWindow(
        title: "The Burgers Taboão"
      ),
      onTap: (){
        print("the burgers clicado");
      },
      // rotation: 45 //rotacionar icone do marcador
    );


    marcadoresLocal.add(marcadorShopping);
    marcadoresLocal.add(marcadorBurger);

    setState(() {
     _marcadores = marcadoresLocal; 
    });
    */

    /*
    Set<Polygon> listaPolygons = {};
    Polygon polygon1 = Polygon(
      polygonId: PolygonId("polygon1"),
      fillColor: Colors.yellow,
      strokeColor: Colors.red,
      strokeWidth: 10,
      points: [
        LatLng(-23.609132, -46.767732),
        LatLng(-23.607944, -46.766287),
        LatLng(-23.608544, -46.759388),
        LatLng(-23.610893, -46.760354),
      ],
      consumeTapEvents: true,
      onTap: (){
        print("area clicado");
      },
      zIndex: 1
    );

    Polygon polygon2 = Polygon(
      polygonId: PolygonId("polygon2"),
      fillColor: Colors.purple,
      strokeColor: Colors.green,
      strokeWidth: 10,
      points: [
        LatLng(-23.608189, -46.766995),
        LatLng(-23.607501, -46.764388),
        LatLng(-23.610696, -46.763497),
      ],
      consumeTapEvents: true,
      onTap: (){
        print("area clicado");
      },
      zIndex: 0
    );

    listaPolygons.add( polygon1 );
    listaPolygons.add( polygon2 );

    setState((){
     _polygons = listaPolygons; 
    });
    */

    Set<Polyline> listaPolylines = {};
    Polyline polyline = Polyline(
      polylineId: PolylineId("polyline"),
      color: Colors.green,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      jointType: JointType.bevel,
      points: [
        LatLng(-23.608189, -46.766995),
        LatLng(-23.607501, -46.764388),
        LatLng(-23.610696, -46.763497),
      ],
      consumeTapEvents: true,
      onTap: (){
        print("area clicada");
      }
    );

    listaPolylines.add( polyline );
    setState(() {
     _polylines = listaPolylines; 
    });
  }

  _recuperarLocalizacaoAtual() async{
    Position position = await Geolocator().getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );

    Marker marcadorUsuario = Marker(
      markerId: MarkerId("marcador-usuario"),
      position: LatLng(position.latitude, position.longitude),
      infoWindow: InfoWindow(
        title: "Localização do usuário"
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueGreen
      ),
      onTap: (){
        print("Usuario clicado");
      }
    );

    setState(() {
     _marcadores.add(marcadorUsuario);
     _posicaoCamera = CameraPosition(
       target: LatLng(position.latitude, position.longitude),
       zoom: 17
     );
     _movimentarCamera();
    });
    // print("Localização atual: " + position.toString() );
  }

  _adcionarListenerLocalizacao(){

    var geolocator = Geolocator();
    var locationOptions = LocationOptions(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10
    );
    geolocator.getPositionStream(locationOptions)
      .listen((Position position){
      print("Localização atual: " + position.toString() );    

      setState(() {
        // -23.608202, -46.768346
        // -23.610503, -46.768142
      _posicaoCamera = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 17
      );
      _movimentarCamera();
      });

    });
  }
  
  _recuperarLocalParaEndereco() async {

    List<Placemark> listaEnderecos = await Geolocator()
        .placemarkFromAddress("Av. Aprigio Bezerra da Silva, 1525");

    print("total: " + listaEnderecos.length.toString() );

    if (listaEnderecos != null && listaEnderecos.length > 0) {
      
      Placemark endereco = listaEnderecos[0];

      String resultado = "\n administrativeArea " + endereco.administrativeArea;
      resultado += "\n subAdministrativeArea " + endereco.subAdministrativeArea;
      resultado += "\n locality " + endereco.locality;
      resultado += "\n subLocality " + endereco.subLocality;
      resultado += "\n thoroughfare " + endereco.thoroughfare;
      resultado += "\n subThoroughfare " + endereco.subThoroughfare;
      resultado += "\n postalCode " + endereco.postalCode;
      resultado += "\n country " + endereco.country;
      resultado += "\n isoCountryCode " + endereco.isoCountryCode;
      resultado += "\n position " + endereco.position.toString();

      print("resultado: " + resultado);
      //-23.610503, -46.768142
    }

  }

  _recuperarLocalParaLatLong() async {

    List<Placemark> listaEnderecos = await Geolocator()
        .placemarkFromCoordinates(-23.610503, -46.768142);

    print("total: " + listaEnderecos.length.toString() );

    if (listaEnderecos != null && listaEnderecos.length > 0) {
      
      Placemark endereco = listaEnderecos[0];

      String resultado = "\n administrativeArea " + endereco.administrativeArea;
      resultado += "\n subAdministrativeArea " + endereco.subAdministrativeArea;
      resultado += "\n locality " + endereco.locality;
      resultado += "\n subLocality " + endereco.subLocality;
      resultado += "\n thoroughfare " + endereco.thoroughfare;
      resultado += "\n subThoroughfare " + endereco.subThoroughfare;
      resultado += "\n postalCode " + endereco.postalCode;
      resultado += "\n country " + endereco.country;
      resultado += "\n isoCountryCode " + endereco.isoCountryCode;
      resultado += "\n position " + endereco.position.toString();

      print("resultado: " + resultado);

    }

  }

  @override
  void initState(){
    super.initState();
    // _carregarMarcadores();
    // _recuperarLocalizacaoAtual();
    // _adcionarListenerLocalizacao();
    // _recuperarLocalParaEndereco();
    _recuperarLocalParaLatLong();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mapas e geolocalização"),),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: _movimentarCamera,
      ),
      body: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          // mapType: MapType.none,
          // mapType: MapType.satellite,
          // mapType: MapType.terrain,
          // mapType: MapType.hybrid,
          //-23.6093853,-46.7706047
          //-23.6098392,-46.7702875
          initialCameraPosition: _posicaoCamera,
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
          // markers: _marcadores,
          // polygons: _polygons,
          // polylines: _polylines,
        ),
      ),
      
    );
  }
}