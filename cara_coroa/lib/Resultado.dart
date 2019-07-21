import 'package:flutter/material.dart';

class Resultado extends StatefulWidget {
  String valor;  

  Resultado(this.valor);

  @override
  _ResultadoState createState() => _ResultadoState();
}

class _ResultadoState extends State<Resultado> {
   @override
  Widget build(BuildContext context) {
    
    var caminhoImagem = "images/moeda_cara.png";
    if(widget.valor == "cara"){
      caminhoImagem = "images/moeda_cara.png";
    }else{
      caminhoImagem = "images/moeda_coroa.png";
    }

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
              child: Image.asset(caminhoImagem),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                  // print("images/botao_" + widget.valor + ".png");
                }, 
                child: Image.asset('images/botao_voltar.png'),
               ),
            ),
          ],
        ),
      ),
    );
  }
}