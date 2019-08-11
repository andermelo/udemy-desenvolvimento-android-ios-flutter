import 'package:flutter/material.dart';
import 'Login.dart';
import 'RouteGenerator.dart';

void main(){
  runApp(
    MaterialApp(
      home: Login(),
      theme: ThemeData(
        primaryColor: Color(0xff075e54),
        accentColor: Color(0xff25d366)
      ),
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    )
  );
}