import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'Post.dart';

class RequisaoPost extends StatefulWidget {
  @override
  _RequisaoPostState createState() => _RequisaoPostState();
}

class _RequisaoPostState extends State<RequisaoPost> {

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
   
   var corpo = json.encode(
      {
        "userId": 1,
        "id": null,
        "title": "",
        "body": ""
      }  
   );

   http.Response response = await http.post(
     _urlBase + "/posts",
     headers: {"Content-type": "application/json; charset=UTF-8"},
     body: corpo
   );

   print("respota: ${response.statusCode}");
   print("respota: ${response.body}");

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
                  child: Text("Salvar", style: TextStyle(color: Colors.white),),
                  onPressed:(){} ,
                ),
                RaisedButton(
                  color: Colors.black,
                  child: Text("Salvar", style: TextStyle(color: Colors.white),),
                  onPressed: (){},
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