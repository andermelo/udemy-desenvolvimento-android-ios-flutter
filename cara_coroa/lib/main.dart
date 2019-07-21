import 'dart:math';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:cara_coroa/Resultado.dart';

void main(){
  runApp(
    MaterialApp(
      home: AberturaApp(),
      debugShowCheckedModeBanner: false,
    )
  );
}

class AberturaApp extends StatefulWidget {
  @override
  _AberturaAppState createState() => _AberturaAppState();
}

class _AberturaAppState extends State<AberturaApp> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new HomePage(),
      title: new Text('Seja bem-vindo'.toUpperCase(),
        style: new TextStyle(
          color: Colors.white,
          fontSize: 20.0
        ),
      ),
      image: Image.asset("images/logo.png"),
      backgroundColor: Color(0xff61bd86),
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: ()=>print("Flutter Egypt"),
      loaderColor: Colors.white
    );
  }
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  void _exibirResultado(){
    var itens = ["cara", "coroa"];
    var numero = Random().nextInt( itens.length );
    var resultado = itens[numero];
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => Resultado(resultado)
      )
    );
    print(resultado);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff61bd86),//usando cor #ffcc80
      // backgroundColor: Color.fromRGBO(255, 204, 128, 1), // usando RGB
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(25),
              child: Image.asset('images/logo.png'),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: GestureDetector(
                onTap: _exibirResultado,
                child: Image.asset('images/botao_jogar.png'),
               ),
            ),
          ],
        ),
      ),
    );
  }
}