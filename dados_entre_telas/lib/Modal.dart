import 'package:flutter/material.dart';

class Modal{

  void mainBottomSheet(BuildContext context){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _itemMenu(context, 'Mensagem', Icons.message, _action1),
            _itemMenu(context, 'Tirar foto', Icons.camera_alt, _action2),
            _itemMenu(context, 'Galeria', Icons.photo_library, _action3),
          ],
        );
      }
    );
  }

  ListTile _itemMenu(BuildContext context, String nome, IconData icone, Function action){
    return ListTile(
      leading: Icon(icone),
      title: Text(nome),
      onTap: (){
        Navigator.pop(context);
        action();
      },
    );
  }

  _action1(){
    print("action 1");
  }

  _action2(){
    print("action 2");
  }

  _action3(){
    print("action 3");
  }
}
