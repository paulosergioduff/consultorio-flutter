import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(MyWebApp());
}

class MyWebApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'nunito',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WebHomePage(),
    );
  }
}
