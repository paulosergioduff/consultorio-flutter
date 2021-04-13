// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:sub_locacoes/engine/xrud.dart';
import 'package:sub_locacoes/services/services-main.dart';
import 'home.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

String nomeDeDocumento = "beta";

Future<void> mudaTela(tela) async {
  MaterialPageRoute(builder: (context) => tela()); // Muda a tela
}

Future<void> completaCadastro() async {
  String domainRegister = setDomain(nomeDeDocumento).toString();
  String domainTarget = "$domainRegister/common-users/data";

  Map<String, Object> dados = {
    'Nome': "$completaNome",
    'idade': "$completaIdade",
    'telefone': "$completaTelefone",
    'CRP:': "$completaCrp",
    'email de contato': "$completaEmail",
    'abordagem': "$completaAbordagem",
    'Tempo de formação:': "$completaTempoFormacao",
    'Especialidade': "$completaEspecialidade",
    'Formação': "$completaFormacao"
  };

  XrudSend("$domainTarget", "$nomeDeDocumento", dados);
  mudaTela(MyHomePage);
}

String completaNome = "Nome padrão";
String completaIdade = "00-00";
String completaTelefone = "555-555";
String completaCrp = "CRP - 00";
String completaEmail = "emailPadrao";
String completaAbordagem = "Abordagem: fff";
String completaTempoFormacao = "000";
String completaEspecialidade = "especialidade";
String completaFormacao = "Formacao";

/// Entrypoint example for registering via Email/Password.
class RegisterPage extends StatefulWidget {
  /// The page title.
  final String title = 'Cadastro';

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nome = TextEditingController();
  final TextEditingController _idade = TextEditingController();
  final TextEditingController _telefone = TextEditingController();
  final TextEditingController _crp = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _abordagem = TextEditingController();
  final TextEditingController _tempoFormacao = TextEditingController();
  final TextEditingController _especialidade = TextEditingController();
  final TextEditingController _formacao = TextEditingController();

  bool _success;
  String _userEmail = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            Form(
                key: _formKey,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Por favor, insira o email';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(labelText: 'Senha'),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Por favor, insira a senha';
                            }
                            return null;
                          },
                          obscureText: true,
                        ),
                        TextFormField(
                          controller: _nome,
                          decoration: const InputDecoration(labelText: 'Nome'),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Por favor, insira seu nome';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _idade,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Idade'),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Por favor, insira sua idade';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _telefone,
                          keyboardType: TextInputType.number,
                          decoration:
                              const InputDecoration(labelText: 'Telefone'),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Por favor, insira seu telefone';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _crp,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'CRP'),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Por favor, insira o número do seu CRP';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _email,
                          decoration: const InputDecoration(
                              labelText: 'Email mais usado para contato'),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Por favor, insira o novo campo';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _abordagem,
                          decoration:
                              const InputDecoration(labelText: 'Abordagem'),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Por favor, insira a abordagem que trabalha';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _tempoFormacao,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              labelText: 'Tempo de formação (em anos)'),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Por favor, insira o tempo de formação';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _especialidade,
                          decoration:
                              const InputDecoration(labelText: 'Especialidade'),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Por favor, insira sua especialidade';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _formacao,
                          decoration: const InputDecoration(
                              labelText: 'Nível de formação'),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Por favor, insira o nível de formação';
                            }
                            return null;
                          },
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          alignment: Alignment.center,
                          child: SignInButtonBuilder(
                            icon: Icons.person_add,
                            backgroundColor: Colors.blueGrey,
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                await _register();
                              }
                            },
                            text: 'Cadastro',
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(_success == null
                              ? ''
                              : (_success
                                  ? 'Cadastro feito com sucesso para o email $_userEmail'
                                  : 'O cadastro falhou!')),
                        )
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Example code for registration.
  Future<void> _register() async {
    completaNome = _nome.text;
    completaIdade = _idade.text;
    completaTelefone = _telefone.text;
    completaCrp = _crp.text;
    completaEmail = _email.text;
    completaAbordagem = _abordagem.text;
    completaTempoFormacao = _tempoFormacao.text;
    completaEspecialidade = _especialidade.text;
    completaFormacao = _formacao.text;

    nomeDeDocumento = _emailController.text;

    try {
      final User user = (await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
      if (user != null) {
        setState(() {
          _success = true;
          _userEmail = user.email;
        });
        Navigator.push(
          // Muda de página
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SubLocacoes()), //  MyHomePage()), // Nova tela após logado
        );
        completaCadastro();
      } else {
        _success = false;
      }
    } catch (e) {
      Scaffold.of(context).showSnackBar(
        const SnackBar(
          content: Text('Falha ao tentar cadastrar'),
        ),
      );
    }
  }
}
