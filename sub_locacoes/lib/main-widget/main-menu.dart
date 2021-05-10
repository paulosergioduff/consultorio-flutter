import 'package:flutter/material.dart';
import 'package:sub_locacoes/engine/xrud.dart';
import 'package:sub_locacoes/engine/read-demo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(StartMenu()); //Enviando commit
}

class ReadDocument extends StatelessWidget {
  final String documentId;
  final String collection;

  ReadDocument(this.documentId, this.collection);

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection(collection);

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          String mensageiro = "Um erro ocorreu durante a leitura do sistema";
          return ListBody(
            children: <Widget>[
              Text(mensageiro),
              // Text('Would you like to approve of this message?'),
            ],
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> retorno = snapshot.data.data();
          return Text(
              "Olha a novidade aí gente: Full Name: ${retorno['full_name']} Data: ${retorno['age']}");
        }

        return Text("loading");
      },
    );
  }
}

final FirebaseAuth _auth = FirebaseAuth.instance;

// Example code for sign out.
Future<void> _signOut() async {
  await _auth.signOut();
}

class StartMenu extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        fontFamily: 'Nunito-ExtraLight',
        primarySwatch: Colors.blue,
      ),
      home: SystemMenuPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class SystemMenuPage extends StatefulWidget {
  SystemMenuPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SystemMenuPageState createState() => _SystemMenuPageState();
}

class _SystemMenuPageState extends State<SystemMenuPage> {
  int _counter = 0;
  String menssage;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(color: Colors.purple),
            ),
            ListTile(
              title: Text('Início'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Meus agendamentos'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Pagamentos'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Ranking'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Sair'),
              onTap: () async {
                final User user = _auth.currentUser;
                if (user == null) {
                  Scaffold.of(context).showSnackBar(const SnackBar(
                    content: Text('Usuário ainda não foi logado'),
                  ));
                  return;
                }
                await _signOut();

                final String uid = user.uid;
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('$uid Foi deslogado com sucesso'),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
