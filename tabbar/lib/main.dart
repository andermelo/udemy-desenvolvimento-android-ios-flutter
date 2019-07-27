import 'package:flutter/material.dart';
import 'PrimeiraPagina.dart';
import 'SegundaPagina.dart';
import 'TerceiraPagina.dart';

void main(){
  runApp(
    MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    )
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 3, 
      vsync: this,
      initialIndex: 2
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Abas"),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              // text: "Home",
              icon: Icon(Icons.home),
            ),
            Tab(
              // text: "E-mail",
              icon: Icon(Icons.email),
            ),
            Tab(
              // text: "Conta",
              icon: Icon(Icons.account_circle),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          PrimeiraPagina(),
          SegundaPagina(),
          TerceiraPagina()
        ],
      ),      
    );
  }
  
}