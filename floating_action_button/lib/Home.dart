import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FloatingActionButton"),
      ),
      body: Center(child: Text("Conteúdo"),),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // mudar localização do FloatingActionButton
      // floatingActionButton: FloatingActionButton(
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add_shopping_cart),
        label: Text("Adiconar"),
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(2)
        ),
        // shape: _DiamondBorder(),
        backgroundColor: Colors.red,
        // foregroundColor: Colors.black, //cor do icone ou fonte
        // elevation: 5, //configurar sombra
        // mini: true, //diminuir o tamanho padrao
        // child: Icon(Icons.add),
        // onPressed: (){
        //   print("Resultado: botao pressionado");
        // },
      ),

      bottomNavigationBar: BottomAppBar(
        // shape:CircularNotchedRectangle(),
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.menu),
            )
          ],
        ),
      ),
    );
  }
}

class _DiamondBorder extends ShapeBorder {
  const _DiamondBorder();

  @override
  EdgeInsetsGeometry get dimensions {
    return const EdgeInsets.only();
  }

  @override
  Path getInnerPath(Rect rect, { TextDirection textDirection }) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, { TextDirection textDirection }) {
    return Path()
      ..moveTo(rect.left + rect.width / 2.0, rect.top)
      ..lineTo(rect.right, rect.top + rect.height / 2.0)
      ..lineTo(rect.left + rect.width  / 2.0, rect.bottom)
      ..lineTo(rect.left, rect.top + rect.height / 2.0)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, { TextDirection textDirection }) {}

  // This border doesn't support scaling.
  @override
  ShapeBorder scale(double t) {
    return null;
  }
}