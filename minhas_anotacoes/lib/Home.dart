import 'package:flutter/material.dart';
import 'package:minhas_anotacoes/model/Anotacao.dart';
import 'package:minhas_anotacoes/helper/AnotacaoHelper.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _tituloController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();

  var _db = AnotacaoHelper();

  _exibirTelaCadastro(){

    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text("adicionar anotação"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _tituloController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: "Título",
                  hintText: "Digite o título..."
                ),
              ),
              TextField(
                controller: _descricaoController,
                decoration: InputDecoration(
                  labelText: "Descrição",
                  hintText: "Digite a descrição..."
                ),
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: ()=>Navigator.pop(context),
              child: Text("Cancelar"),
            ),
            FlatButton(
              onPressed: (){

                _salvarAnotacao();

                Navigator.pop(context);
              },
              child: Text("Salvar"),
            )
          ],
        );  
      }
    );
  }

  _salvarAnotacao() async {

    String titulo = _tituloController.text;
    String descricao = _descricaoController.text;

    // print("data atual: " + DateTime.now().toString());

    Anotacao anotacao = Anotacao(titulo, descricao,  DateTime.now().toString());
    int resultado = await _db.salvarAnotacao(anotacao);

    print("salvar anotacao: " + resultado.toString() );


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas anotaçoes"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: (){
          _exibirTelaCadastro();
        },
      ),
    );
  }
}

