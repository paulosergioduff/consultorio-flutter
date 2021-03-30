import 'package:flutter/material.dart';
import 'package:sub_locacoes/telas/meus_agendamentos.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../main.dart';

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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => MeusAgendametnos()));
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
        primarySwatch: Colors.purple,
        primaryColor: const Color(0xFF6d63ea), //6d63ea
        accentColor: const Color(0xFF9c27b0),
        canvasColor: const Color(0xFFfafafa),
      ),
      /* home: Scaffold(
          //body: //AuthTypeSelector(),
          ),*/
    );
  }
}
