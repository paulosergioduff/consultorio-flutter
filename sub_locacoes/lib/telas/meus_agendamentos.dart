import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sub_locacoes/apps/calendario/calendario-main.dart';
import 'package:sub_locacoes/engine/xrud.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import 'package:sub_locacoes/clone/engine/yellow-widgets.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final User user = _auth.currentUser;

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

final rotareserva = "$colletionDomain/reserva/data";
final rotaagendamentos = "$colletionDomain/agendamentos/data";

aceitarReserva(reserva, autor, dominio, horario) async {
  Map<String, Object> dados = {
    'reserva': reserva,
    'autor': autor,
    'dominio': dominio,
    'horario': horario
  };

  XrudSend(rotaagendamentos, reserva, dados);
}

regeitarReserva(reserva) {
  XrudDelete(rotareserva, reserva);
}

class MeusAgendametnos extends StatefulWidget {
  @override
  _MeusAgendametnosState createState() => _MeusAgendametnosState();
}

class _MeusAgendametnosState extends State<MeusAgendametnos> {
  // ====================================================== //
  String stdName, stdID, programID;
  double stdGPA;
  getautor(name) {
    this.stdName = name;
  }

  getreserva(id) {
    this.stdID = id;
  }

  gethorario(pid) {
    this.programID = pid;
  }

  getdominio(result) {
    this.stdGPA = double.parse(result);
  }

  // TODO Create Data
  createData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection(rotareserva).doc(stdName);

    // create Map to send data in key:value pair form
    Map<String, dynamic> students = ({
      "autor": stdName,
      "reserva": stdID,
      "horario": programID,
      "dominio": stdGPA
    });

    // send data to Firebase
    documentReference
        .set(students)
        .whenComplete(() => print('$stdName created'));
  }

  // TODO Read Data
  readData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection(rotareserva).doc(stdName);

    documentReference.get().then((dataSnapshot) {
      print(dataSnapshot.data()["autor"]);
      print(dataSnapshot.data()["reserva"]);
      print(dataSnapshot.data()["horario"]);
      print(dataSnapshot.data()["dominio"]);
    });
  }

  // TODO Update Data
  updateData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection(rotareserva).doc(stdName);

    Map<String, dynamic> students = ({
      "autor": stdName,
      "reserva": stdID,
      "horario": programID,
      "dominio": stdGPA
    });

    // update data to Firebase
    documentReference
        .set(students)
        .whenComplete(() => print('$stdName updated'));
  }

  // TODO Delete Data
  deleteData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection(rotareserva).doc(stdName);

    // delete data from Firebase
    documentReference.delete().whenComplete(() => print('$stdName deleted'));
  }
  // ====================================================== //

  @override
  Widget build(BuildContext context) {
    String autor;
    String reserva;
    String horario;
    String dominio;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Meus agendamentos'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: 15.0),
              Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      elevation: 8.0,
                      onPressed: () => createData(),
                      color: const Color(0xFF6d63ea),
                      child: Text('Novo',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      textColor: Colors.white,
                      shape: raisedButtonBorder(),
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      elevation: 8.0,
                      onPressed: () => readData(),
                      color: const Color(0xFF6d63ea),
                      child: Text('Atualizar',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      textColor: Colors.white,
                      shape: raisedButtonBorder(),
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      elevation: 8.0,
                      onPressed: () => updateData(),
                      color: const Color(0xFF6d63ea),
                      child: Text('Alterar',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      textColor: Colors.white,
                      shape: raisedButtonBorder(),
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      elevation: 8.0,
                      onPressed: () => deleteData(),
                      color: const Color(0xFF6d63ea),
                      child: Text('Cancelar',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      textColor: Colors.white,
                      shape: raisedButtonBorder(),
                    ),
                  ),
                ],
              ),
              Divider(thickness: 1.0, height: 25.0, color: Colors.green),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Name',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Data',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Horário',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'CGPA',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(rotareserva)
                    .snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot documentSnapshot =
                            snapshot.data.docs[index];
                        if (documentSnapshot["autor"] == user.email) {
                          autor = documentSnapshot["autor"];
                          reserva = documentSnapshot["reserva"];
                          horario = documentSnapshot["horario"];
                          dominio = documentSnapshot["dominio"];
                        }
                        return Row(
                          children: [
                            Expanded(
                              child: Text("$autor"),
                            ),
                            Expanded(
                              child: Text("$reserva"),
                            ),
                            Expanded(
                              child: Text("$horario"),
                            ),
                            Expanded(
                              child: Text("$dominio"),
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
            ],
          ),
        ),
      ),
    );
  }
}

InputDecoration textFieldInputDecoration(String labelText, Icon iconType) {
  return InputDecoration(
    fillColor: Colors.grey.withOpacity(0.1),
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      borderSide: BorderSide(color: Colors.blue, width: 2.0),
    ),
    prefixIcon: iconType,
    labelText: labelText,
    labelStyle: TextStyle(fontSize: 16.0),
  );
}

TextStyle simpleTextStyle() {
  return TextStyle(fontSize: 17.0);
}

RoundedRectangleBorder raisedButtonBorder() {
  return RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0));
}
