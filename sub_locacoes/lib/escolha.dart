import 'dart:ui';

import 'package:flutter/material.dart';
import './Cadastro.dart';
import './AdminCadastro.dart';
import 'Login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      home: SignInPage()
    );
  }
}

class Escolha extends StatefulWidget {
  Escolha({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EscolhaState createState() => _EscolhaState();
}

class _EscolhaState extends State<Escolha> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
      ),
      body: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraints) {
          return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage())),
            
            child: Card(
              
            child: Container(
              width: constraints.maxWidth / 2,
              height: constraints.maxHeight * .7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Image.asset("assets/images/escolha1.jpg"),
                Container(
                  height: 10,
                ),
                Text("Sou Profissional", style:TextStyle(color:const Color(0xFF443e92), fontSize: 15)),
              ],), 
            )
            
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AdminRegisterPage())),
            child: Card(
            child: Container(
              width: constraints.maxWidth / 2,
              height: constraints.maxHeight * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Image.asset("assets/images/escolha2.jpg"),
                Container(
                  height: 10,
                ),
                Text("Tenho um Consultório", style: TextStyle(color: const Color(0xFF443e92), fontSize: 15)),

              ],), 
            )
            
            ),
          ),
          ],
        );

        }

         
      ),
    );
  }

}