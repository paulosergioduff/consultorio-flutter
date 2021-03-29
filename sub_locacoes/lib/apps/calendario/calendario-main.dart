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

final rotacrud = "$colletionDomain/reserva/data";

CollectionReference agendamentos =
    FirebaseFirestore.instance.collection(rotacrud);

agendarData(dataAlvo) {
  Map<String, Object> dados = {'studentName': dataAlvo};

  String dataAlvoString = dataAlvo.toString();

  var arr1 = dataAlvoString.split(' ');
  var domain1 = arr1[0];
  var dataRecebida = domain1.toString();
  //DateTime.now()

  String hojeString = DateTime.now().toString();

  var arr2 = hojeString.split(' ');
  var domain2 = arr2[0];
  var hoje = domain2.toString();

  if (dataRecebida != hoje) {
    XrudSend(rotacrud, dataRecebida, dados);
    MaterialPageRoute(builder: (BuildContext context) => MyHomePage());
  }
}

class _HomeState extends State<CalendarioInterface> {
  DateTime dateTime;
  DateTime hoje;
  Duration duration;

  @override
  void initState() {
    dateTime = DateTime.now();
    duration = Duration(minutes: 10);
    super.initState();
  }

  List<DateTime> diasCancelados = [
    DateTime.now(),
  ];

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
                  Text("Confirmar $dateTime"),
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
                    agendarData("$dateTime");
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
