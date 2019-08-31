import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapa extends StatefulWidget {
  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _marcadores = {};

  _onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
  }

  _exibirMarcador( LatLng latLng){

    Marker marcador = Marker(
      markerId: MarkerId("marcador-${latLng.latitude}-${latLng.longitude}"),
      position: latLng,
      infoWindow: InfoWindow(
        title: "Marcador"
      )
    );

    setState(() {
     _marcadores.add(marcador); 
    });

    // print("local clicado: " + latLng.toString());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mapa"),),
      body: Container(
        child: GoogleMap(
          markers: _marcadores,
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(-23.562436,-46.655005),
            zoom: 18
          ),
          onMapCreated: _onMapCreated,
          onLongPress: _exibirMarcador,
        ),
      ),
    );
  }
}