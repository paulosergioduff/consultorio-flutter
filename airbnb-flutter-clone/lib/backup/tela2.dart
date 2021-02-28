import 'package:airbnb_clone/Constants/Constants.dart';
import 'package:airbnb_clone/Routes/Profile.dart';
import 'package:airbnb_clone/Routes/SearchScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//void main() => runApp(MyApp());

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Início da build do widget
    return Scaffold(
      // Aqui escolhemos uma estrutura de widget. Seja Scaffold ou material app (se for no início do app)
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
          /* children: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Voltar 33'),
        ),*/
          ),
      drawer: Container(color: Colors.white),
    );
  }
}
