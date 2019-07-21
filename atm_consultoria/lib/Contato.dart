import 'package:flutter/material.dart';
import 'package:undraw/undraw.dart';

class Contato extends StatefulWidget {
  @override
  _ContatoState createState() => _ContatoState();
}

class _ContatoState extends State<Contato> {
  Color color = Colors.green;
  UnDrawIllustration illustration = UnDrawIllustration.connected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contato"),
        backgroundColor: color,
      ),
      body: UnDraw(
        color: color,
        illustration: illustration,
        placeholder: Text("Illustration is loading..."),
        errorWidget: Icon(Icons.error_outline, color: Colors.red, size: 50),
      ),
    );
  }
}