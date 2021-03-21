import 'package:flutter/material.dart';
import 'package:sub_locacoes/engine/xrud.dart';
import 'package:sub_locacoes/engine/read-demo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp()); //Enviando commit
}

class ReadDocument extends StatelessWidget {
  final String documentId;
  final String collection;

  ReadDocument(this.documentId, this.collection);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            Map<String, Object> dados = {
              'full_name': "teste de vida",
              'age': 18
            };
            String documentName = document.data()['full_name'];
            XrudSend("recebe", documentName, dados);
            return new ListTile(
              title: new Text(document.data()['full_name']),
              subtitle: new Text(document.data()['age']),
            );
          }).toList(),
        );
      },
    );
  }
}

final FirebaseAuth _auth = FirebaseAuth.instance;

// Example code for sign out.
Future<void> _signOut() async {
  await _auth.signOut();
}

class MyApp extends StatelessWidget {
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
        primarySwatch: Colors.blue,
      ),
      home: MyCRUDPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyCRUDPage extends StatefulWidget {
  MyCRUDPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyCRUDPageState createState() => _MyCRUDPageState();
}

class _MyCRUDPageState extends State<MyCRUDPage> {
  int _counter = 0;
  String menssage;

  //_counter++;
  //setState(())
/*
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }*/
//Fonte: https://medium.com/flutterdevs/using-firebase-firestore-in-flutter-b0ea2c62bc7
  Future<String> _incrementCounter() async {
    setState(() {
      _counter++;
      //print(XrudRead("users", "global-function"));
    });

    Map<String, Object> dados = {'full_name': "Mary novidade", 'age': 18};
    XrudSend("users", "testFunction", dados);
    //XrudDelete("users", "global-function");
    //ReadDemo("users", "global-function");
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyCRUDPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new ReadDocument("finalmente", "users"),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
