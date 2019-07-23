import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'Post.dart';

class Lista extends StatefulWidget {
  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {

  //https://jsonplaceholder.typicode.com/

  String _urlBase = "https://jsonplaceholder.typicode.com";

  // Post post = Post(0,1,'','');

  Future<List<Post>> _recuperarPostagens() async{

    http.Response response = await http.get(_urlBase + "/posts");
    var dadosJson = json.decode(response.body);

    List<Post> postagens = List();
    for(var post in dadosJson){
      print("post: " + post["title"]);
      Post p = Post(post["userId"], post["id"], post["title"], post["body"]);
      postagens.add(p);
    }

    return postagens;
    // print(postagens.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Consumo de serviço avançado"),
      ),
      body: FutureBuilder<List<Post>>(
        future: _recuperarPostagens(),
        builder: (context, snapshot){

          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              print("conexao waiting");
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              print("conexao done");
              if(snapshot.hasError){
                print("erro ao carregar");
              }else{
                print("lista: carregou");
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index){

                    List<Post> lista = snapshot.data;
                    Post post = lista[index];

                    return ListTile(
                      title: Text(post.title),
                      subtitle: Text(post.id.toString()),
                    );
                  },
                );
              }
              break;
          }
        }
      ),
    );
  }
}