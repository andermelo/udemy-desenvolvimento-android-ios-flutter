import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

void main(){
  runApp(
    MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    )
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AudioPlayer audioPlayer = AudioPlayer();

  AudioCache audioCache = AudioCache(prefix: "audios/");
  bool primeiraExecucao = true;

  _executar() async{

    if(primeiraExecucao){
      audioPlayer = await audioCache.play("musica.mp3");
      primeiraExecucao = false;
    }else{
      audioPlayer.resume();
    }


    /*
    String url = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-13.mp3";
    int resultado = await audioPlayer.play(url);

    if(resultado == 1){
      //sucesso
    }else{

    }
    */

  }

  _pausar()async{

    int resultado = await audioPlayer.pause();
    if(resultado == 1){
      //sucesso
    }else{

    }
  }

  _parar()async{

    int resultado = await audioPlayer.stop();
    if(resultado == 1){
      //sucesso
    }else{

    }

  }

  @override
  Widget build(BuildContext context) {
    // _executar();
    return Scaffold(
      appBar: AppBar(
        title: Text("Exexutando Sons"),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Slider

              //1
              Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  child: Image.asset("assets/images/executar.png"),
                  onTap: (){
                    _executar();
                  },
                ),
              ),
              //2
              Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  child: Image.asset("assets/images/pausar.png"),
                  onTap: (){
                    _pausar();
                  },
                ),
              ),
              //3
              Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  child: Image.asset("assets/images/parar.png"),
                  onTap: (){
                    _parar();
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}