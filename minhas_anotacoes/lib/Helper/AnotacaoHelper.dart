import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AnotacaoHelper {

  static final AnotacaoHelper _anotacaoHelper = AnotacaoHelper._internal();
  Database _db;



  factory AnotacaoHelper(){
    return _anotacaoHelper;
  }

  AnotacaoHelper._internal(){

  }

  get db async {
    
    if( _db != null ){
      return _db;
    }else{

    }
  }

  _onCreate(Database, int version) async {

    /*
      id titulo descricao data
      01 teste  teste     02/10/2010
    */

    String sql = "CREATE TABLE anotacao (id INTEGER PRIMARY KEY AUTOINCREMENTE, titulo VARCHAR, descricao TEXT, data DATETIME)";
    await db.execute(sql);
  }

  inicializarDB()async{

    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados= join(caminhoBancoDados, "banco_minhas_anotacoes.db");

    var db = await openDatabase(localBancoDados, version: 1, onCreate: _onCreate);
    return db;
  }

}

/*

class Normal{
  
  Normal(){
    
  }
  
}

class Singleton{
  
  static final Singleton _singleton = Singleton._internal();
  
  factory Singleton(){
    print("Singleton");
    return _singleton;
  }
    
  Singleton._internal(){
    print("_internal");
  }
}

void main(){
  
  var i1 = Normal();  
  var i2 = Normal();
  
  var s1 = Singleton(); 
  print("*************");
  var s2 = Singleton();
  
  
  
//   print( i1 == i2 );  
  
  print( s1 == s2 );

  
}

*/