import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main-widget/common.dart';
import 'package:sub_locacoes/clone/Routes/Ongoing.dart';
import 'main.dart';
import 'package:sub_locacoes/main-widget/common.dart';

void main() {
  runApp(SubLocacoes());
}

class SubLocacoes extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sub Locações',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        primaryColor: const Color(0xFF6d63ea), //6d63ea
        accentColor: const Color(0xFF9c27b0),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: MyHomePage(title: 'Sub Locações'), // Passando parametros como texto
    );
  }
}

final FirebaseAuth _auth = FirebaseAuth.instance;

// Example code for sign out.
Future<void> _signOut() async {
  await _auth.signOut();
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() =>
      MaterialPageRoute(builder: (context) => Ongoing()); // Muda a tela

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sub Locações"), // Passando paramtro -->(widget.title),
      ),
      drawer: menuPrincipal(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Usar listView deslizável com imagens do OnGoing

            RaisedButton(
              child: Text('Iniciar agendamento'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Ongoing()),
                );
              },
            ),
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // */ //This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Opcao {
  const Opcao({this.titulo, this.icon});

  final String titulo;
  final IconData icon;
}

const List<Opcao> opcoes = const <Opcao>[
  const Opcao(titulo: 'Carro', icon: Icons.directions_car),
  const Opcao(titulo: 'Bike', icon: Icons.directions_bike),
  const Opcao(titulo: 'Barco', icon: Icons.directions_boat),
  const Opcao(titulo: 'Ônibux', icon: Icons.directions_bus),
  const Opcao(titulo: 'Trem', icon: Icons.directions_railway),
  const Opcao(titulo: 'Andar', icon: Icons.directions_walk),
  const Opcao(titulo: 'Carro', icon: Icons.directions_car),
  const Opcao(titulo: 'Bike', icon: Icons.drafts),
  const Opcao(titulo: 'Barco', icon: Icons.dvr),
  const Opcao(titulo: 'Copy', icon: Icons.copyright),
  const Opcao(titulo: 'Train', icon: Icons.cloud_off),
  const Opcao(titulo: 'Car', icon: Icons.directions_car),
  const Opcao(titulo: 'Bike', icon: Icons.directions_bike),
  const Opcao(titulo: 'Barco', icon: Icons.directions_boat),
  const Opcao(titulo: 'Ônibus', icon: Icons.directions_bus),
  const Opcao(titulo: 'Trem', icon: Icons.directions_railway),
  const Opcao(titulo: 'Andar', icon: Icons.directions_walk),
  const Opcao(titulo: 'Carro', icon: Icons.directions_car),
  const Opcao(titulo: 'Bike', icon: Icons.drafts),
  const Opcao(titulo: 'Barco', icon: Icons.dvr),
];

class OpcaoCard extends StatelessWidget {
  const OpcaoCard({Key key, this.opcao}) : super(key: key);
  final Opcao opcao;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
        color: Colors.white,
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(opcao.icon, size: 80.0, color: textStyle.color),
                Text(opcao.titulo, style: textStyle),
              ]),
        ));
  }
}
