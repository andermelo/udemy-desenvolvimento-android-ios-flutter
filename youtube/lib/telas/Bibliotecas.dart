import 'package:flutter/material.dart';

class Bibliotecas extends StatefulWidget {
  @override
  _BibliotecasState createState() => _BibliotecasState();
}

class _BibliotecasState extends State<Bibliotecas> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Biblioteca",
          style: TextStyle(
            fontSize: 25
          ),
        ),
      ),
    );
  }
}

