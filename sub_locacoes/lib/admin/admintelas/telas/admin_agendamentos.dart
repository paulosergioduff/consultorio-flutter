import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: AdminAgendametnos(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.purple,
    ),
  ));
}

class AdminAgendametnos extends StatefulWidget {
  @override
  _AdminAgendametnosState createState() => _AdminAgendametnosState();
}

class _AdminAgendametnosState extends State<AdminAgendametnos> {
  List<dynamic> diasCancelados = [];
  int contador = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Admin agendamentos'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new CircularProgressIndicator(),
              new Text("Aguarde"),
              SizedBox(height: 15.0),

              StreamBuilder(
                  stream:
                      FirebaseFirestore.instance.collection('crud').snapshots(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot documentSnapshot =
                            snapshot.data.docs[index];
                        diasCancelados.add(documentSnapshot["studentName"]);
                        contador++;
                        int qtItens = snapshot.data.docs.length.toInt();
                        if (contador == qtItens) {
                          contador = 0;
                          return Text(
                              "Fim do percurso ->" + diasCancelados.toString());
                        }
                        return Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                  initialValue: diasCancelados.toString()),
                            ),
                            Text("teste-> c: $contador qt:$qtItens"),
                          ],
                        );
                      },
                    );
                  }),
              Text("Admin results: \n " + diasCancelados.toString()),
              // Linpando lista
            ],
          ),
        ),
      ),
    );
  }
}
