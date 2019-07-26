import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _lista = ["Anderson", "Pedro", "Luana"];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Utilizando Dismissible widget"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _lista.length,
              itemBuilder: (context, index){

                final item = _lista[index];

                return Dismissible(
                  background: Container(
                    color: Colors.red,
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.edit,
                          color: Colors.white
                        )
                      ],
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Icon(
                          Icons.delete,
                          color: Colors.white
                        )
                      ],
                    ),
                  ),
                  // direction: DismissDirection.up, //padrao é horizontal
                  onDismissed: (direction){
                    if(direction == DismissDirection.endToStart){
                       print("direção: " + direction.toString());
                    }else if ( direction == DismissDirection.startToEnd){
                      print("direcao: " + direction.toString());
                    }

                    setState(() {
                       _lista.removeAt(index);
                    });
                  },
                  key: Key( item ),
                  child: ListTile(
                    title: Text(item),
                  ),
                );
              },
            ),
          )
        ],
      )
    );
  }
}