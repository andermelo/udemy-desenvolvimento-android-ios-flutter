import 'package:flutter/material.dart';
import 'package:undraw/undraw.dart';

class Servico extends StatefulWidget {
  @override
  _ServicoState createState() => _ServicoState();
}

class _ServicoState extends State<Servico> {
  Color color = Colors.green;
  UnDrawIllustration illustration = UnDrawIllustration.connected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Serviços"),
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