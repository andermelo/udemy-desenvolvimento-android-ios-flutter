import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Home.dart';

void main(){

  Firestore.instance
  .collection("usuarios")
  .document("001")
  .setData({"nome":"Anderson"});

  runApp(
    MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    )
  );
}