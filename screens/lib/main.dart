// Pacotes airbnb clone
import 'dart:ui';
import 'package:screens/Routes/Ongoing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:screens/Routes/HomePage.dart';
import 'Constants/Constants.dart';
import 'Routes/login.dart';
// Fim dos pacotes airbnb

// Pacote para chamar tela de abertura
import 'splash.dart';

import 'constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: APP_NAME,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash(),
    );
  }
}
