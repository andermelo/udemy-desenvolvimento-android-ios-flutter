import 'package:flutter/material.dart';
import 'package:undraw/undraw.dart';

class Empresa extends StatefulWidget {
  @override
  _EmpresaState createState() => _EmpresaState();
}

class _EmpresaState extends State<Empresa> {
  Color color = Colors.green;
  UnDrawIllustration illustration = UnDrawIllustration.connected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Empresa"),
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