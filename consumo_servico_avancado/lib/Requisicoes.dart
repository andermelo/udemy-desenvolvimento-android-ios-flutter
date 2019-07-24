import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'Post.dart';

class Requisicoes extends StatefulWidget {
  @override
  _RequisicoesState createState() => _RequisicoesState();
}

class _RequisicoesState extends State<Requisicoes> {

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

  _post() async{
   
  //  Post post = new Post(120,null,"","");

   Post post = new Post(120, null, "Titulo", "Corpo da mensagem");

   var corpo = json.encode(
      post.toJson()
   );

   http.Response response = await http.post(
     _urlBase + "/posts/",
     headers: {"Content-type": "application/json; charset=UTF-8"},
     body: corpo
   );

   print("respota: ${response.statusCode}");
   print("respota: ${response.body}");

  }

  _put() async{

    // PUT atualizar o objeto todo

        Post post = new Post(120, null, "Titulo", "Corpo da mensagem");

        var corpo = json.encode(
            post.toJson()
        );

        http.Response response = await http.put(
          _urlBase + "/posts/2",
          headers: {"Content-type": "application/json; charset=UTF-8"},
          body: corpo
        );

        print("resposta: ${response.statusCode}");
        print("resposta: ${response.body}");
    }

  _patch() async{

    // PATCH atualizar elementos individuais do objeto

        Post post = new Post(120, null, "Titulo", "Corpo da mensagem");

        var corpo = json.encode(
            post.toJson()
        );

        http.Response response = await http.patch(
          _urlBase + "/posts/2",
          headers: {"Content-type": "application/json; charset=UTF-8"},
          body: corpo
        );

        print("resposta: ${response.statusCode}");
        print("resposta: ${response.body}");
  }

  _delete() async {
       http.Response response = await http.delete(
          _urlBase + "/posts/2",
          // headers: {"Content-type": "application/json; charset=UTF-8"},
          // body: corpo
       );

       if(response.statusCode == 200){
         print("Deus certo a requisição");
       }else{
         print("nao deu certo!");
       }

       print("resposta: ${response.statusCode}");
       print("resposta: ${response.body}");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Consumo de serviço avançado"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RaisedButton(
                  color: Colors.black,
                  child: Text("Salvar", style: TextStyle(color: Colors.white),),
                  onPressed:_post,
                ),
                RaisedButton(
                  color: Colors.black,
                  child: Text("Atualizar", style: TextStyle(color: Colors.white),),
                  // onPressed:_put,
                  onPressed: _patch,
                ),
                RaisedButton(
                  color: Colors.black,
                  child: Text("Remover", style: TextStyle(color: Colors.white),),
                  onPressed: _delete,
                )
              ],
            ),
            Expanded(
                child: FutureBuilder<List<Post>>(
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
                      if(snapshot.hasError){
                        print("erro ao carregar");
                      }else{
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
            )

          ],
        ),
      ),
    );
  }
}