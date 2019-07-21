import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main(){
  runApp(
    MaterialApp(
      home: AberturaApp(),
      debugShowCheckedModeBanner: false,
    )
  );
}

class AberturaApp extends StatefulWidget {
  @override
  _AberturaAppState createState() => _AberturaAppState();
}

class _AberturaAppState extends State<AberturaApp> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 14,
      navigateAfterSeconds: new AfterSplash(),
      title: new Text('Jogue sempre!',
        style: new TextStyle(
          color: Colors.white,
          fontSize: 20.0
        ),
      ),
      image: Image.asset("images/logo.png"),
      backgroundColor: Colors.green,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: ()=>print("Flutter Egypt"),
      loaderColor: Colors.white
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
      title: new Text("Welcome In SplashScreen Package"),
      automaticallyImplyLeading: false
      ),
      body: new Center(
        child: new Text("Done!",
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30.0
        ),),

      ),
    );
  }
}