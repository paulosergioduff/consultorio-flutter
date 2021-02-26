import 'package:screens/Constants/Constants.dart';
import 'package:screens/Routes/Profile.dart';
import 'package:screens/Routes/SearchScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//void main() => runApp(MyApp());

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
