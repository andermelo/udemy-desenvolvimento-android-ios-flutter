import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() => runApp(
    MaterialApp(
      home: Home(),
    )
  );

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  _recuperarBancoDados() async{

    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "my_first_banco.db");

    var bd = await openDatabase(
      localBancoDados,
      version: 1,
      onCreate: (db, dbVersaoRecente){
        String sql = 'CREATE TABLE usuarios (id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR, idade INTEGER)';
        db.execute(sql);
      }
    );

    return bd;

    // print( "aberto: " + bd.isOpen.toString() );

  }

  _salvar() async {

    Database bd = await _recuperarBancoDados();

    Map<String, dynamic> dadosUsuario = {
      "nome" : "João Maria",
      "idade" : 57
     };

    int id = await bd.insert("usuarios", dadosUsuario);
    print("Salvo: $id");
  }

  _listarUsuarios() async {

    Database bd = await _recuperarBancoDados();

    // String sql = "SELECT * FROM usuarios WHERE ida = 0 ";
    // String sql = "SELECT * FROM usuarios WHERE idade >= 29";
    // String sql = "SELECT * FROM usuarios WHERE idade BETWEEN 29 AND 50";
    // String sql = "SELECT * FROM usuarios WHERE idade in ('Anderson Melo',29)";
    // String sql = "SELECT * FROM usuarios WHERE nome = 'Anderson Melo'";
    // String sql = " SELECT * FROM usuarios WHERE nome LIKE '%son%' "; //usando o coringa
    // String sql = " SELECT * FROM usuarios WHERE 1=1 ORDER BY UPPER(nome) DESC "; //ASC ou DESC
    // String sql = " SELECT * FROM usuarios WHERE 1=1 ORDER BY UPPER(nome) DESC LIMIT 3"; // limitar consulta 
    String sql = " SELECT * FROM usuarios ";
    List usuarios = await bd.rawQuery(sql);

    for(var usuario in usuarios){
      print(
        "item id: " + usuario['id'].toString() +
        " item nome: " + usuario['nome'] +
        " item idade: " + usuario['idade'].toString() 
      );
    }

    // print("usuarios: " + usuarios.toString());
  }

  _listarUsuarioPeloId(int id) async{

    Database bd = await _recuperarBancoDados();

    //CRUD -> Create, Read, Update and Delete
    List usuarios = await bd.query(
      "usuarios",
      columns: ["id", "nome", "idade"],
      where: "id = ?",
      whereArgs: [id]
    );

    for(var usuario in usuarios){
      print(
        "item id: " + usuario['id'].toString() +
        " item nome: " + usuario['nome'] +
        " item idade: " + usuario['idade'].toString() 
      );
    }
  }

  _excluirUsuario(int id) async {
    Database bd = await _recuperarBancoDados();

    int retorno = await bd.delete(
      "usuarios",
      where: "nome = ? AND  idade = ?",
      whereArgs: ["Anderson Melo", 29]
      // where: "id = ?",
      // whereArgs: [id]
    );

    print("item qtde removida: $retorno");

  }

   _atualizarUsuario(int id) async {
    Database bd = await _recuperarBancoDados();

    Map<String, dynamic> dadosUsuario = {
      "nome" : "Pedro Melo",
      "idade" : 0
    };

    int retorno = await bd.update(
      "usuarios", 
      dadosUsuario,
      where: "id = ?",
      whereArgs: [id]
    );

    print("item qtde atualizada: $retorno");

  }

  @override
  Widget build(BuildContext context) {

    // _recuperarBancoDados();
    _salvar();
    // _listarUsuarioPeloId(5);
    // _excluirUsuario(2);
    // _listarUsuarios();
    // _atualizarUsuario(1);

    return Container(
      
    );
  }
}