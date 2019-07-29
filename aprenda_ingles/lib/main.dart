import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      home: Home(),
    )
  );
}

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
    _tabController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aprenda Inglês"),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              text: "Bichos",
            ),
            Tab(
              text: "Números",
            ),
            Tab(
              text: "Vogais",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Center(child: Text("Vai"),),
          Center(child: Text("Dormir"),),
          Center(child: Text("Karai!"),),
        ],
      ),
    );
  }
}