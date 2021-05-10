import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Loading(),
    ),
  );
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text(
            'Future Builder',
          ),
        ),
        body: buildContainer());
  }

  Container buildContainer() {
    return Container(
        child: FutureBuilder(
            future: getFutureDados(),
            initialData: "Aguardando os dados...",
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: Text(
                    snapshot.data,
                    style: TextStyle(fontSize: 20.0),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  Future<String> getFutureDados() async =>
      await Future.delayed(Duration(seconds: 10), () {
        return 'Dados recebidos...';
      });
}
