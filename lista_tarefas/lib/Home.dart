import 'package:flutter/material.dart';
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
  TextEditingController _controllerTarefa = TextEditingController();

 Future<File> _getFile()async {
    final diretorio = await getApplicationDocumentsDirectory();
    return File("${diretorio.path}/dados.json");
  }

  _salvarTarefa(){

    String textoDigitado = _controllerTarefa.text;

    Map<String, dynamic> tarefa = Map();
    tarefa["titulo"] = textoDigitado;
    tarefa["realizada"] = false;

    setState(() {
      _listaTarefas.add( tarefa );
    });    
    _salvarArquivo();

    _controllerTarefa.text = "";
  }
  _salvarArquivo() async{
    
    var arquivo = await _getFile();

    //Criar dados
    

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

  _lerArquivo() async {
    try{

      final arquivo = await _getFile();
      return arquivo.readAsString();

    }catch(e){
      return null;
    }
  }

  @override
  void initState() {
    super.initState();

    _lerArquivo().then((dados){
      setState(() {
        _listaTarefas = json.decode(dados); 
      });
    });

  }

  @override
  Widget build(BuildContext context) {

    // _salvarArquivo();
    print("itens: " + _listaTarefas.toString());

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
                  return CheckboxListTile(
                    title: Text(_listaTarefas[index]['titulo']),
                    value: _listaTarefas[index]['realizada'],
                    selected: _listaTarefas[index]['realizada'],
                    onChanged: (valor){
                      setState(() {
                       _listaTarefas[index]['realizada'] = valor;
                      });
                       _salvarArquivo(); 
                    },
                  );
                  // return ListTile(
                  //   title: Text(_listaTarefas[index]['titulo']),
                  // );
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
                  controller: _controllerTarefa,
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
                      _salvarTarefa();
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
