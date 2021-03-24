import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sub_locacoes/engine/meus_agendamentos-widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: MeusAgendametnos(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.purple,
    ),
  ));
}

class MeusAgendametnos extends StatefulWidget {
  @override
  _MeusAgendametnosState createState() => _MeusAgendametnosState();
}

class _MeusAgendametnosState extends State<MeusAgendametnos> {
  String stdName, stdID, programID;
  double stdGPA;
  List<dynamic> retemDados;
  String result;

  getStudentName(name) {
    this.stdName = name;
  }

  getStudentID(id) {
    this.stdID = id;
  }

  getStudyProgramID(pid) {
    this.programID = pid;
  }

  getStudentCGPA(result) {
    this.stdGPA = double.parse(result);
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> retemDados = [];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('CRUD App'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: 15.0),
              StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('crud').snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot documentSnapshot =
                            snapshot.data.docs[index];
                        retemDados.add("Nada a declarar\n");
                        return Row(
                          children: [
                            Expanded(
                              child: Text(
                                documentSnapshot["studentName"],
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                documentSnapshot["studentID"],
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                documentSnapshot["studyProgramID"],
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                documentSnapshot["studentCGPA"].toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                      ),
                    );
                  }
                },
              ),
              //String result = retemDados.toString();
              Text("Nossos results: \n " + retemDados.toString() + ""),
            ],
          ),
        ),
      ),
    );
  }
}
