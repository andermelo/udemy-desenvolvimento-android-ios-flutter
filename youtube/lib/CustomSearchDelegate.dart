import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: (){
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // print("digitado: " + query);

    List<String> lista = List();
    if(query.isNotEmpty){
      lista = [
        "Marte", "Eclipse", "5G", "Fusão", "Nuclear", "Paradoxo"
      ];
      return ListView.builder(
        itemCount: lista.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text( lista[index] ),
          );
        },
      );
    }else{
      return Center(
        child: Text("Digitado algo"),
      );
    }
    
  }
}