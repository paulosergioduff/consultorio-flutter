import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Server> fetchServer() async {
  final response = await http.get(Uri.https('cdn.jsdelivr.net',
      'gh/paulosergioduff/serverbtcapi@master/sublocacoes/subloc-server.json'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Server.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Server');
  }
}

class Server {
  final int userId;
  final int id;
  final String content;

  Server({this.userId, this.id, this.content});

  factory Server.fromJson(Map<String, dynamic> json) {
    return Server(
      userId: json['userId'],
      id: json['id'],
      content: json['content'],
    );
  }
}

void main() => runApp(LendoJsonPage());

class LendoJsonPage extends StatefulWidget {
  LendoJsonPage({Key key}) : super(key: key);

  @override
  _LendoJsonPageState createState() => _LendoJsonPageState();
}

class _LendoJsonPageState extends State<LendoJsonPage> {
  Future<Server> futureServer;

  @override
  void initState() {
    super.initState();
    futureServer = fetchServer();
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
          child: FutureBuilder<Server>(
            future: futureServer,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.content);
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
