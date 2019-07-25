import 'package:http/http.dart' as http;
import 'package:youtube/model/Video.dart';
import 'dart:convert';

//const CHAVE_YOUTUBE_API = "AIzaSyBf6w2hFvxkg3gwObXqsYiMTPJBbnbNozY";
const CHAVE_YOUTUBE_API = "AIzaSyCw6s-VJLY1rxmmO0yRgen1D6pOZf8YCT0";
//const ID_CANAL = "UCmEClzCBDx-vrt0GuSKBd9g"; //Jovem Nerd
const ID_CANAL = "UCn9Erjy00mpnWeLnRqhsA1g"; // Ciência Todo Dia
const URL_BASE = "https://www.googleapis.com/youtube/v3/";

class Api {
  Future<List<Video>> pesquisar(String pesquisa) async {

    http.Response response = await http.get(
      URL_BASE + "search"
        "?part=snippet"
        "&type=video"
        "&maxResults=20"
        "&order=date"
        "&key=$CHAVE_YOUTUBE_API"
        "&channelId=$ID_CANAL"
        "&q=$pesquisa"
    );

    if(response.statusCode == 200){
      // print("Pesquisa deu certo: " + response.body );
      Map<String, dynamic> dadosJson = json.decode(response.body);
      
      List<Video> videos = dadosJson["items"].map<Video>(
        (map){
          return Video.fromJson(map);
          // return Video.ConverterJson(map);
        }
      ).toList();

      return videos;

      // for( var video in videos){
      //   print("resultado: " + video.titulo);
      // }

      // for(var video in dadosJson["items"]){
      //   print("Resultado: " + video.toString());
      // }

      // print("resultado: " + dadosJson["items"][0]["snippet"]["title"].toString());

    }else{

    }

  }
}