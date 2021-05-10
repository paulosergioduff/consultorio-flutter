import 'package:flutter/material.dart';
import 'tela2.dart';

void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Template Project',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: tela1(title: 'Template Project'),

    );
  }
}

class tela1 extends StatefulWidget {
  tela1({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _tela1State createState() => _tela1State();
}


class _tela1State extends State<tela1> {
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
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
            style: new TextStyle(fontSize:36.0,
            color: const Color(0xFF000000),
            fontWeight: FontWeight.w200,
            fontFamily: "Roboto"),
          ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),

       //###### Widget novo ######################
       RaisedButton(
          child: Text('Ir para tela 2'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondRoute()),
            );
          },
        ),
      //############ Widget NOVO #########################
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
