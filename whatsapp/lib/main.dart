import 'dart:io';
import 'package:flutter/material.dart';
import 'Login.dart';
import 'RouteGenerator.dart';

final ThemeData temaPadrao = ThemeData(
        primaryColor: Color(0xff075e54),
        accentColor: Color(0xff25d366)
);

final ThemeData temaIOS = ThemeData(
        primaryColor: Colors.grey[200],
        accentColor: Color(0xff25d366)
);

void main(){
  runApp(
    MaterialApp(
      home: Login(),
      theme: Platform.isIOS ? temaIOS : temaPadrao,
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    )
  );
}