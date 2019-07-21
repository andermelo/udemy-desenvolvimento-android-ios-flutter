import 'package:dados_entre_telas/TelaSecundaria.dart';
import "package:flutter/material.dart";
import 'package:dados_entre_telas/Modal.dart';

void main(){
  runApp(
    MaterialApp(
      home: TelaPrincipal(),
      debugShowCheckedModeBanner: false,
    )
  );
}

class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {

  Modal modal = new Modal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela Principal"),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
                child: RaisedButton(
                child: Text("Ir para a segunda tela"),
                padding: EdgeInsets.all(15),
                onPressed: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => TelaSecundaria(valor: "Anderson Melo",)
                    )
                  );
                },
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.all(15),
            //     child: RaisedButton(
            //     child: Text("Abrir Modal karai"),
            //     padding: EdgeInsets.all(15),
            //     onPressed: () => modal.mainBottomSheet(context),
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: (){
          // _settingModalBottomSheet(context);
          modal.mainBottomSheet(context);
        },
        backgroundColor: Colors.orange,
        child: new Icon(Icons.add),
      ),
    );
  }
}

// void _settingModalBottomSheet(context){
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext bc){
//           return Container(
//             child: new Wrap(
//               children: <Widget>[
//                 new ListTile(
//                   leading: new Icon(Icons.music_note),
//                   title: new Text('Music'),
//                   onTap: () => {}          
//                 ),
//                 new ListTile(
//                   leading: new Icon(Icons.videocam),
//                   title: new Text('Video'),
//                   onTap: () => {},          
//                 ),
//               ],
//             ),
//           );
//       }
//     );
// }