import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // retirar aviso debug
    home: HomeStateful(),
  ));
}

class HomeStateful extends StatefulWidget {
  @override
  _HomeStatefulState createState() => _HomeStatefulState();
}

class _HomeStatefulState extends State<HomeStateful> {

  var _texto = "Anderson Melo";

  @override
  Widget build(BuildContext context) {
    
    print("build foi chamado");

    return Scaffold(
      appBar: AppBar(
        title: Text("Título do App"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: (){
                setState(() {
                  _texto = "Flutter é legal"; 
                });
                // print("Clicado");
              },
              color: Colors.amber,
              child: Text("clique aqui"),
            ),
            Text("Nome: $_texto ")
          ],
        ),
      ),
    );
  }
}

