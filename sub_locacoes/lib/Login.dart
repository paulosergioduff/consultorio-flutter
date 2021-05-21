import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sub_locacoes/escolha.dart';
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
      backgroundColor: const Color(0xFF6d63ea),
    
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
        child: Container(
          
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 170,
                  height: 170,
                  alignment: Alignment.center,
                 child: Image.asset("assets/images/login.jpg"),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF8e87ef),
                    labelText: 'Email',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none )
                  ),
                  
                  validator: (String value) {
                    if (value.isEmpty) return 'Favor preencher email';
                    return null;
                  },
                ),
                Container(
                  height: 30,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration:  InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF8e87ef),
                    labelText: 'Senha',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none
                    )
                    ),
                  validator: (String value) {
                    if (value.isEmpty) return 'Favor informar senha';
                    return null;
                  },
                  obscureText: true,
                ),
                Container(
                  height: 30,
                ),
                Container(
                
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text("Entrar"),
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF443e92),
                          padding: EdgeInsets.symmetric(horizontal: 132, vertical: 21),
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await _signInWithEmailAndPassword();
                          }
                        },
                      ),
                      Container(
                  height: 30,
                ),
                      Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Text("Ainda não tem cadastro? "),
                TextButton(onPressed: (){

                  Navigator.push(
        
                  context,
                  MaterialPageRoute(
                   builder: (context) =>
                 Escolha()), //  MyHomePage()), // Nova tela após logado
                 );
                  
                }, 
                child: Text("Cadaste-se aqui", 
                style: TextStyle(fontWeight: FontWeight.bold),),
                style: TextButton.styleFrom(primary:const Color(0xFF0e2a4a)),)
                ],


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
