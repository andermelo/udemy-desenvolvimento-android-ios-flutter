import 'package:flutter/material.dart';
import 'package:undraw/undraw.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _listaTarefas = [];

  _salvarArquivo() async{
    
    final diretorio = await getApplicationDocumentsDirectory();
    var arquivo = File("${diretorio.path}/dados.json");

    //Criar dados
    Map<String, dynamic> tarefa = Map();
    tarefa["titulo"] = "Ir ao mercado";
    tarefa["realizada"] = false;
    _listaTarefas.add(tarefa);

    /* estrutura de uma tarefa
      [
        {
          titulo: "Ir ao mercado",
          realizada: true
        },
        {
          titulo: "Estudar Flutter",
          realizada: false
        }
      ]
    */

    String dados = json.encode(_listaTarefas);
    arquivo.writeAsString( dados );
    // caminho/dados.json
    // print("Caminho: " + diretorio.path);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de tarefas"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _listaTarefas.length,
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text(_listaTarefas[index]),
                  );
                },
              ),
            ),
          ],
        ),        
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: (){
          showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text("Adiconar tarefa"),
                content: TextField(
                  decoration: InputDecoration(
                    labelText: "Digite sua tarefa",
                  ),
                  onChanged: (text){

                  },
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Cancelar"),
                    onPressed: ()=> Navigator.pop(context)
                  ),
                  FlatButton(
                    child: Text("Confirmar"),
                    onPressed: (){
                      // salvar
                      Navigator.pop(context);  
                    },
                  )
                ],
              );
            }
          );
        },
      ),
    );
  }
}
