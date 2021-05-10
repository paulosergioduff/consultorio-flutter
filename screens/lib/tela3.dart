import 'package:screens/Constants/Constants.dart';
import 'package:screens/Routes/Profile.dart';
import 'package:screens/Routes/SearchScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//void main() => runApp(MyApp());

class ThirdRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Início da build do widget
    return Scaffold(
      // Aqui escolhemos uma estrutura de widget. Seja Scaffold ou material app (se for no início do app)
      appBar: AppBar(
        title: Text("Third Route"),
      ),
      body: Center(
        children: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Voltar para tela 2'),
        ),
      ),
      drawer: Container(color: Colors.white),
    );
  }
}
