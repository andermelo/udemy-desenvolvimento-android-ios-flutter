import 'package:flutter/material.dart';

class AbaContatos extends StatefulWidget {
  @override
  _AbaContatosState createState() => _AbaContatosState();
}

class _AbaContatosState extends State<AbaContatos> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
        "Contatos",
        textAlign: TextAlign.center,
        ),
      ),
    );
  }
}