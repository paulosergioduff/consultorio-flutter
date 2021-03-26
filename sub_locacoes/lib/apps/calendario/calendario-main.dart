import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:flutter_rounded_date_picker/src/material_rounded_date_picker_style.dart';
//import 'package:flutter_rounded_date_picker/src/material_rounded_year_picker_style.dart';

class CalendarioInterface extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

CollectionReference agendamentos =
    FirebaseFirestore.instance.collection('crud');

class _HomeState extends State<CalendarioInterface> {
  DateTime dateTime;
  Duration duration;

  @override
  void initState() {
    dateTime = DateTime.now();
    duration = Duration(minutes: 10);
    super.initState();
  }

  //########### VARIÁVEIS PARA CARREGAMENTO DE DADOS
  List<DateTime> diasCancelados = [];
  int contador = 0;
  //##############################################

  @override
  Widget build(BuildContext context) {
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
                    "Date Time selected",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    "$dateTime",
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Duration Selected",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                  ),
                  Text(
                    "$duration",
                    style: const TextStyle(fontSize: 20),
                  ),
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
                      return Text("Loading");
                    }

                    snapshot.data.docs.map((DocumentSnapshot document) {
                      /* return new ListTile(
                          title: new Text(document.data()['full_name']),
                        );*/
                      diasCancelados
                          .add(DateTime.parse(document.data()["studentName"]));
                    }).toList();

                    /*return new ListView(
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        /* return new ListTile(
                          title: new Text(document.data()['full_name']),
                        );*/
                      }).toList(),
                    );*/
                  },
                ),
                //####################### APP CARREGA DADOS ########################################

                const SizedBox(height: 12),
                const SizedBox(height: 12),
                FloatingActionButton.extended(
                  onPressed: () async {
                    List<DateTime> oldDays = [
                      DateTime.parse("2021-03-10"),
                      DateTime.parse("2021-03-11"),
                      DateTime.parse("2021-03-12"),
                    ];

                    List<DateTime> novosDias = [
                      DateTime.parse("2021-03-11"),
                      DateTime.parse("2021-03-12"),
                      DateTime.parse("2021-03-13"),
                    ];
                    // FOREACH ESTÁ IMPEDINDO INSTALAÇÃO DO APP
                    //novosDias.forEach((element) => diasCancelados.add(element));

                    DateTime newDateTime = await showRoundedDatePicker(
                      context: context,
                      theme: ThemeData(primarySwatch: Colors.blue),
                      imageHeader: AssetImage(
                        "assets/images/calendar_header_rainy.jpg",
                      ),
                      fontFamily: "Mali",
                      description:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                      listDateDisabled: diasCancelados,
                    );
                    if (newDateTime != null) {
                      setState(() => dateTime = newDateTime);
                    }
                  },
                  label: const Text("Rounded Calendar and Custom Font"),
                ),

                //const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Rounded Date Picker'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: _buildBody(),
      ),
    );
  }
}
