import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'mapeando.dart';

Future<Mapeando> buscarServico() async {
  final response = await http.get(Uri.https('cdn.jsdelivr.net',
      'gh/paulosergioduff/serverbtcapi@master/sublocacoes/subloc-server.json'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Mapeando.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Mapeando');
  }
}

void main() => runApp(LendoJsonPage());

class LendoJsonPage extends StatefulWidget {
  LendoJsonPage({Key key}) : super(key: key);

  @override
  _LendoJsonPageState createState() => _LendoJsonPageState();
}

class _LendoJsonPageState extends State<LendoJsonPage> {
  Future<Mapeando> futureMapeando;

  @override
  void initState() {
    super.initState();
    futureMapeando = buscarServico();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resgatando dados do servidor - hot-reload',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Resgatando dados do servidor'),
        ),
        body: Center(
          child: FutureBuilder<Mapeando>(
            future: futureMapeando,
            builder: (context, snapshot) {
              String resultado = snapshot.data.dadoExtraido;
              int resultado2 = snapshot.data.userId;
              if (snapshot.hasData) {
                return telaRecebeParametro(
                  parametro1: resultado,
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class telaRecebeParametro extends StatelessWidget {
  final String parametro1;

  const telaRecebeParametro({Key key, this.parametro1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(parametro1);
  }
}
