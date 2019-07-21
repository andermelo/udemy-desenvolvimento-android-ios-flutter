import 'package:flutter/material.dart';
import 'package:undraw/undraw.dart';

class Cliente extends StatefulWidget {
  @override
  _ClienteState createState() => _ClienteState();
}

class _ClienteState extends State<Cliente> {
  Color color = Colors.green;
  UnDrawIllustration illustration = UnDrawIllustration.connected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cliente"),
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