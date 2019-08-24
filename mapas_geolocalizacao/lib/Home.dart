import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Completer<GoogleMapController> _completer = Completer();

  _onMapCreated( GoogleMapController googleMapController ){
    _completer.complete(googleMapController);
  }

  _movimentarCamera() async{
    GoogleMapController googleMapController = await _completer.future;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(-23.6093853,-46.7706047),
          zoom: 16,
          tilt: 0,
          bearing: 170
        )
      )
    );
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
          initialCameraPosition: CameraPosition(
            target: LatLng(-23.6093853,-46.7706047),
            zoom: 16
          ),
          onMapCreated: _onMapCreated,
        ),
      ),
      
    );
  }
}