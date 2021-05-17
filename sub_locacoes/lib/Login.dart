import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

/// Entrypoint example for various sign-in flows with Firebase.
class SignInPage extends StatefulWidget {
  /// The page title.
  final String title = 'Sub Locações';

  @override
  State<StatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Builder(builder: (BuildContext context) {
            return FlatButton(
              textColor: Theme.of(context).buttonColor,
              onPressed: () async {
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
              //child: const Text('Sair'),
            );
          })
        ],
      ),
      body: Builder(builder: (BuildContext context) {
        return ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            _EmailPasswordForm(),
          ],
        );
      }),
    );
  }

  // Example code for sign out.
  Future<void> _signOut() async {
    await _auth.signOut();
  }
}

class _EmailPasswordForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmailPasswordFormState();
}

class _EmailPasswordFormState extends State<_EmailPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Autenticação',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (String value) {
                    if (value.isEmpty) return 'Favor preencher email';
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Senha'),
                  validator: (String value) {
                    if (value.isEmpty) return 'Favor informar senha';
                    return null;
                  },
                  obscureText: true,
                ),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        child: Text("Entrar"),
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF6d63ea),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await _signInWithEmailAndPassword();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Example code of how to sign in with email and password.
  Future<void> _signInWithEmailAndPassword() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;

      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('${user.email} Logado'),
        ),
      );

      Navigator.push(
        // Muda de página
        context,
        MaterialPageRoute(
            builder: (context) =>
                SubLocacoes()), //  MyHomePage()), // Nova tela após logado
      );
    } catch (e) {
      Scaffold.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Falha ao tentar logar com email e senha. Verifique as credenciais.'),
        ),
      );
    }
  }
}
