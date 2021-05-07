import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sub_locacoes/clone/Routes/HomePage.dart';
import 'package:sub_locacoes/telas/meus_agendamentos.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sub_locacoes/telas/ranking.dart';
import '../main.dart';
import 'package:sub_locacoes/admin/admintelas/telas/admin_agendamentos.dart';
import 'package:sub_locacoes/admin/admintelas/telas/criarQuartos.dart';
import 'package:sub_locacoes/telas/relatorios.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

// Example code for sign out.
Future<void> _signOut() async {
  await _auth.signOut();
}

class menuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            color: const Color(0xFF6d63ea),
            child: DrawerHeader(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/drawer.png"),
                  radius: 80,
                )
              ],
            )),
          ),
          Container(
            color: const Color(0xFF6d63ea),
            child: Column(
              children: [
                ListTile(
                  title: Text('Início', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: Text('Meus agendamentos',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MeusAgendametnos()));
                  },
                ),
                ListTile(
                  title:
                      Text('Relatórios', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MyWebView(
                              title: "Meus relatórios",
                              selectedUrl: "https://sublocacoesweb.web.app/",
                            )));
                  },
                ),
                ListTile(
                  title: Text(
                    'Pagamentos',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: Text('Ranking', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => Ranking(
                              title: "Ranking",
                              selectedUrl: "https://sublocacoesweb.web.app/",
                            )));
                  },
                ),
                ListTile(
                  title: Text('Sair', style: TextStyle(color: Colors.white)),
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

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MyApp()));

                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('$uid Foi deslogado com sucesso'),
                    ));
                  },
                ),
                ListTile(
                  title: Text(''),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: Text(''),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AdminMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/images/drawer.png"),
                radius: 60,
              )
            ],
          )),
          ListTile(
            title: Text('Início'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('Nova sala'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => CriarQuartos()));
            },
          ),
          ListTile(
            title: Text('Agendamentos'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => AdminAgendametnos()));
            },
          ),
          ListTile(
            title: Text('Relatórios'),
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

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => MyApp()));

              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('$uid Foi deslogado com sucesso'),
              ));
            },
          ),
        ],
      ),
    );
  }
}

class TemaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sub Locações',
      theme: ThemeData(
        primarySwatch: Colors.white,
        primaryColor: const Color(0xFF6d63ea), //6d63ea
        accentColor: const Color(0xFF6d63ea),
        //accentColor: const Color(0xFF9c27b0),
        canvasColor: const Color(0xFFfafafa),
      ),
      /* home: Scaffold(
          //body: //AuthTypeSelector(),
          ),*/
    );
  }
}

List<dynamic> _xrudControllerResult;

class XrudReadField extends StatefulWidget {
  List<dynamic> entrada;

  XrudReadField({Key key, this.entrada}) : super(key: key);

  @override
  _XrudReadFieldState createState() => _XrudReadFieldState();
}

class _XrudReadFieldState extends State<XrudReadField> {
  CollectionReference agendamentos =
      FirebaseFirestore.instance.collection('crud');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: agendamentos.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return new CircularProgressIndicator();
        }

        snapshot.data.docs.map((DocumentSnapshot document) {
          _xrudControllerResult
              .add(DateTime.parse(document.data()["studentName"]));
        }).toList();
      },
    );
  }
}

class MainAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sub Locações',
      theme: ThemeData(
        primarySwatch: Colors.white,
        primaryColor: const Color(0xFF6d63ea),
        accentColor: const Color(0xFF6d63ea),
        // primaryColor: const Color(0xFF9c27b0),
        // accentColor: const Color(0xFF9c27b0),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: MyHomePage(title: 'Sub Locações'), // Passando parametros como texto
    );
  }
} //teste
