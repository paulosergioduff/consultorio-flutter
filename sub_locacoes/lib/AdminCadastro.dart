// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// @dart=2.9

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:sub_locacoes/Cadastro.dart';
import 'package:sub_locacoes/engine/xrud.dart';
import 'package:sub_locacoes/services/services-main.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
String nomeDeDocumento = "beta";

String completaNome = "name_system";
String completaEmail = "system_email@email.com";
String completaClinica = "company_system";
String completaEndereco = "address_system";
String completaTelefone = "555-555-555";

Future<void> completaCadastro() async {
  String domainRegister = setDomain(nomeDeDocumento).toString();
  String domainTarget = "$domainRegister/admin/users";

  Map<String, Object> dados = {
    'Nome': "$completaNome",
    'Clínica': "$completaClinica",
    'Email de contato': "$completaEmail",
    'Endereço': "$completaEndereco",
    'Telefone': "$completaTelefone",
    'Domain': "$domainTarget"
  };

  XrudSend("$domainTarget", "$nomeDeDocumento", dados);
}

/// Entrypoint example for registering via Email/Password.
class AdminRegisterPage extends StatefulWidget {
  /// The page title.
  final String title = 'Cadastro';

  @override
  State<StatefulWidget> createState() => _AdminRegisterPageState();
}

class _AdminRegisterPageState extends State<AdminRegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _clinica = TextEditingController();
  final TextEditingController _endereco = TextEditingController();
  final TextEditingController _nome = TextEditingController();
  final TextEditingController _telefone = TextEditingController();
  final TextEditingController _emailContao = TextEditingController();

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
                          controller: _clinica,
                          decoration:
                              const InputDecoration(labelText: 'Clínica'),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Qual o nome da sua clínica?';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _emailContao,
                          decoration: const InputDecoration(
                              labelText: 'Email mais utilizado'),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Por favor, insira o email';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _endereco,
                          decoration: const InputDecoration(
                              labelText: 'Endereço completo'),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Por favor, insira o endreço completo';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _nome,
                          decoration:
                              const InputDecoration(labelText: 'Nome completo'),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Por favor, insira o novo campo';
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
    completaEmail = _emailContao.text;
    completaClinica = _clinica.text;
    completaEndereco = _endereco.text;
    completaTelefone = _telefone.text;

    nomeDeDocumento = _emailController.text;

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
    } else {
      _success = false;
    }
    completaCadastro();
  }
}
