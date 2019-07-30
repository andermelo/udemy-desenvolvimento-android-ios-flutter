import 'package:flutter/material.dart';
import 'package:aprenda_ingles/telas/Bichos.dart';
import 'package:aprenda_ingles/telas/Numeros.dart';
import 'package:aprenda_ingles/telas/Vogais.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 0
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose(); // remover objeto quando nao for mais utilzado
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aprenda Inglês"),
        bottom: TabBar(
          controller: _tabController,
          indicatorWeight: 4,
          indicatorColor: Colors.white,
          labelStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
          //labelColor: Colors.purple,
          //unselectedLabelColor: Colors.red,
          tabs: <Widget>[
            Tab(text: "Bichos",),
            Tab(text: "Números",),
            Tab(text: "Vogais",),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Bichos(),
          Numeros(),
          Vogais()
        ],
      ),
    );
  }
}