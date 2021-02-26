import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'tela2.dart';

import 'constants.dart';

class MyHomePage extends StatefulWidget {
  @override
  _tela1 createState() => _tela1();
}

class _tela1 extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_NAME),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Open route'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondRoute()),
            );
          },
        ),
      ),
    );
  }
}
