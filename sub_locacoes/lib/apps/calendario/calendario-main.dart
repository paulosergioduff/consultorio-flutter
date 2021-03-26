import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sub_locacoes/engine/xrud.dart';
import '../../home.dart';

class CalendarioInterface extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

CollectionReference agendamentos =
    FirebaseFirestore.instance.collection('crud');

agendarData(dataAlvo) {
  Map<String, Object> dados = {'studentName': dataAlvo};

  XrudSend("crud", dataAlvo, dados);
  MaterialPageRoute(builder: (context) => MyHomePage());
}

class _HomeState extends State<CalendarioInterface> {
  DateTime dateTime;
  DateTime hoje;
  Duration duration;

  @override
  void initState() {
    dateTime = DateTime.now();
    hoje = DateTime.now();

    duration = Duration(minutes: 10);
    super.initState();
  }

  List<DateTime> diasCancelados = [];

  @override
  Widget build(BuildContext context) {
    //String novo = "teste";
    Widget _buildBody() {
      return Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Horário selecionado",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[600],
                    ),
                  ),
                  //XrudSend("users", "refactory", dados);
                  ElevatedButton(
                      onPressed: agendarData("$dateTime"),
                      child: Text("Confirmar $dateTime"))
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 50),
              children: <Widget>[
                //####################### APP CARREGA DADOS ########################################
                StreamBuilder<QuerySnapshot>(
                  stream: agendamentos.snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return new CircularProgressIndicator();
                    }

                    snapshot.data.docs.map((DocumentSnapshot document) {
                      diasCancelados
                          .add(DateTime.parse(document.data()["studentName"]));
                    }).toList();
                  },
                ),
                //####################### APP CARREGA DADOS ########################################

                const SizedBox(height: 12),
                const SizedBox(height: 12),
                FloatingActionButton.extended(
                  onPressed: () async {
                    DateTime newDateTime = await showRoundedDatePicker(
                      context: context,
                      theme: ThemeData(primarySwatch: Colors.blue),
                      imageHeader: AssetImage(
                        "assets/images/calendar_header_rainy.jpg",
                      ),
                      fontFamily: "Mali",
                      description:
                          "Escolha no calendário entre as datas disponíveis.",
                      listDateDisabled: diasCancelados,
                    );
                    if (newDateTime != null) {
                      setState(() => dateTime = newDateTime);
                    }
                  },
                  label: const Text("Selecionar data"),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Calendário'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: _buildBody(),
      ),
    );
  }
}
