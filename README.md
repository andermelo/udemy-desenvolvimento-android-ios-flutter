# Desenvolvimento Android e IOS com Flutter

![Flutter](https://flutter.dev/assets/homepage/news-2-599aefd56e8aa903ded69500ef4102cdd8f988dab8d9e4d570de18bdb702ffd4.png)

## Material desenvolvido durante o curso na [Udemy](https://www.udemy.com/desenvolvimento-android-e-ios-com-flutter/)

### Sumário 

1. [Criando meu primeiro App](https://github.com/andermelo/udemy-desenvolvimento-android-ios-flutter/tree/master/primeiro_app)
1. Aprenda Dart do zero
1. Dart Intermediário e avançado
    1. [Funções](https://gist.github.com/andermelo/4e4b32f8b240d7bb5d829f141113392c#file-funcoes-dart)
    1. [Funções anônimas & parâmetros](https://gist.github.com/andermelo/4e4b32f8b240d7bb5d829f141113392c#file-funcoes-dart)
    1. [Classes e objetos](https://gist.github.com/andermelo/)
    1. [Construtores](https://gist.github.com/andermelo/)
    1. [Getter e Setter](https://gist.github.com/andermelo/)
    1. [Herança](https://gist.github.com/andermelo/)
    1. [Sobrescrita de métodos](https://gist.github.com/andermelo/)
    1. [Modificadores Static e Final](https://gist.github.com/andermelo/)
    1. [Classes abstratas](https://gist.github.com/andermelo/)
    1. [Interface](https://gist.github.com/andermelo/)
    1. [Mixins](https://gist.github.com/andermelo/)
    1. [Coleções - listas](https://gist.github.com/andermelo/)
    1. [Coleções - mapas](https://gist.github.com/andermelo/)
1. Resumo da Linguagem Dart
1. Componentes de interface
    1. Colunas e linhas
    1. [Formatação de textos](#formatação-de-textos)
    1. [Botões](#botões)
    1. [Espaçamento](#espaçamento)
    1. [Alinhamento](#alinhamento)
    1. [Imagens](#imagens)
    1. [Layout base com Scaffold](#layout-base-com-scaffold)
    1. [Widgets - Stateless & Stateful](#widgets---stateless--stateful)
    1. [App 1 Frases do Dia](frases_do_dia/)
    1. [App 2 JokenPo](/jokenpo)
1. Componentes de entrada de dados
    1. [Utilizando caixas de texto](entrada_dados/lib/CampoTexto.dart)
    1. [App 3 Etanol ou Gasolina](alcool_ou_gasolina/)
    1. [Utilizando Checkbox](entrada_dados/lib/EntradaCheckbox.dart)
    1. [Utilizando RadioButton](entrada_dados/lib/EntradaRadioButton.dart)
    1. [Utilizando Switch](entrada_dados/lib/EntradaSwitch.dart)
    1. [Utilizando Slider](entrada_dados/lib/EntradaSlider.dart)
1. Navegação
    1. [Navegando entre telas](#)
    1. [App 4 ATM Consultoria](#)
    1. [Passando dados entre telas](#)
    1. [App 5 Cara ou Coroa](#)
    1. [Nomeando rotas](#)
1. Consumo de serviço web
1. Manipulação de dados
1. Mídias
1. Firebase
1. WhatsApp
1. [Recursos utilizados](#recursos-utilizados)
1. [Referência bibliográfica](#referência-bibliográfica)

## Formatação de textos
```dart
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Frases do dia",
    home: Container(
      color: Colors.white,
      child: Column(
          children: <Widget>[
          Text(
              "Mussum Ipsum",
              style: TextStyle(
                fontSize: 50,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.normal,
                letterSpacing: 0,
                wordSpacing: 0,
                decoration: TextDecoration.underline,
                decorationColor: Colors.black,
                decorationStyle: TextDecorationStyle.solid,
                color: Colors.blue),
            ),
          ],
        ),
    ),
  ));
}
```

## Botões
```dart
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Frases do dia",
    home: Container(
      color: Colors.white,
      child: Column(
          children: <Widget>[
            FlatButton(
                onPressed: (){
                  print("botao pressionado");
                }, 
                child: Text("Botão",
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                      decoration: TextDecoration.none                      
                    ),
                )
              )
          ],
        ),
    ),
  ));
}
```
## Espaçamento
```dart
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Frases do dia",
    home: Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      // margin: EdgeInsets.all(30),
      margin: EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
        border: Border.all(width: 3, color: Colors.white)
      ),
      // color: Colors.white,
      child: Column(
          children: <Widget>[
            Text("t1"),

            Padding(
              padding: EdgeInsets.all(30),
              child: Text("t2"),
            ),

            Text("t3"),
            // Text(
            //   "Manduma pindureta quium dia nois paga. Todo mundo vê os porris que eu tomo, mas ninguém vê os tombis que eu levo!",
            //   textAlign: TextAlign.justify,
            // )
          ],
        ),
    ),
  ));
}
```

## Alinhamento
```dart
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Frases do dia",
    home: Container(
      margin: EdgeInsets.only(top: 40),
      decoration: BoxDecoration(
        border: Border.all(width: 3, color: Colors.white)
      ),
      // color: Colors.white,
      child: Column(
          children: <Widget>[
            Text("Salsicha"),
            Text("Batata"),
            Text("Frango"),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
    ),
  ));
}
```

## Imagens
> É necessário alterar o arquivo `pubspec.yaml` para incluir as imagens no projeto primeiro

```
...
  assets:
    - images/mesa.jpg
    - images/parque.jpg
...
```

```dart
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // retirar aviso debug
    title: "Frases do dia",
    home: Container(
      margin: EdgeInsets.only(top: 40),
      decoration: BoxDecoration(
        border: Border.all(width: 3, color: Colors.white)
      ),
      // color: Colors.white,
      child: Image.asset(
        "images/mesa.jpg",
        fit: BoxFit.scaleDown,
      ),
    ),
  ));
}
```
> Mais em [flutter.dev/.../images-class.html](https://api.flutter.dev/flutter/widgets/Image-class.html)

##  Layout base com Scaffold
> Scaffold class layout base para o seu app

```dart
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // retirar aviso debug
    home: Scaffold(
      appBar: AppBar(
        title: Text("Título do App na Classe AppBar"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Text("Conteúdo principal"),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlue,
        child: Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              children: <Widget>[
                Text("Conteúdo na Classe BottomAppBar"),
              ],
            ),
          ),
      ),
    ),
  ));
}
```

## Widgets - Stateless & Stateful

> Stateless -> Widgets que não podem ser alterados (constantes)

![Stateless](assets/images/exemplo-stateless.gif)

> Stateful -> Widgets que podem ser alterados (variáveis)

![Stateful](assets/images/exemplo-stateful.gif)

## Recursos utilizados
* DartPad - editor online para linguagem Dart [dartpad.dartlang.org](https://dartpad.dartlang.org/)
* [Flutter](https://flutter.dev/docs)
* Visual Studio Code
* [Material Design](https://material.io/)

## Referência Bibliográfica

* Dart [dart.dev](https://dart.dev/guides)
* Flutter [flutter.dev](https://flutter.dev/docs)
* Material Design [material.io](https://material.io/)
