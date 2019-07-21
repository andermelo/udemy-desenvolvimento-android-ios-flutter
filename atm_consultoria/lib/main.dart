import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:atm_consultoria/Servico.dart';
import 'package:atm_consultoria/Contato.dart';
import 'package:atm_consultoria/Cliente.dart';
import 'package:atm_consultoria/Empresa.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1524749292158-7540c2494485?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
  'https://images.unsplash.com/photo-1471970394675-613138e45da3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=80',
  'https://images.unsplash.com/photo-1519358263235-23d672f60c19?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
  'https://images.unsplash.com/photo-1544717301-9cdcb1f5940f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80'
];

void main(){
  runApp(
    MaterialApp(
      home: PaginaPrincipal(),
      debugShowCheckedModeBanner: false,
    )
  );
}

class PaginaPrincipal extends StatefulWidget {
  @override
  _PaginaPrincipalState createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {

  void _abrirEmpresa(){
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => Empresa())
    );
  }
  void _abrirContato(){
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => Contato())
    );
  }
  void _abrirServico(){
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => Servico())
    );
  }
  void _abrirCliente(){
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => Cliente())
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("ATM Consultoria"),
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Padding(
              padding: EdgeInsets.all(25),
              child: Image.asset(
                "images/logo.png",
                height: 250,
                fit: BoxFit.scaleDown,
                ),
            ),

            CarouselSlider(
                viewportFraction: 0.9,
                aspectRatio: 2.0,
                autoPlay: true,
                enlargeCenterPage: true,
                pauseAutoPlayOnTouch: Duration(seconds: 3),
                items: imgList.map(
                  (url) {
                    return Container(
                      margin: EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: Image.network(
                          url,
                          fit: BoxFit.cover,
                          width: 1000.0,
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
              
              Padding(
                padding: EdgeInsets.all(25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                      onTap: _abrirEmpresa,
                      child: Image.asset("images/menu_empresa.png", width: 80,),
                    ),
                    GestureDetector(
                      onTap: _abrirServico,
                      child: Image.asset("images/menu_servico.png", width: 80,),
                    ),
                    GestureDetector(
                      onTap: _abrirCliente,
                      child: Image.asset("images/menu_cliente.png", width: 80,),
                    ),
                    GestureDetector(
                      onTap: _abrirContato,
                      child: Image.asset("images/menu_contato.png", width: 80,),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}