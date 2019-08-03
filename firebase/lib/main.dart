import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main(){

  Firestore.instance
    .collection("usuários")
    .document("pontuacao")
    .setData({"Anderson": "90", "Pedro": "350"});

  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}