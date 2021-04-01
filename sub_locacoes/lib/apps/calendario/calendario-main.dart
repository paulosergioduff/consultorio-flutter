import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sub_locacoes/engine/xrud.dart';
import '../../home.dart';
import 'package:intl/intl.dart';

//DateFormat dateFormat = DateFormat("HH:mm");
DateTime dateTime;
DateTime hoje;
Duration duration;
DateTime hora;
List horasplit;
String horaString;

final rotareserva = "$colletionDomain/reserva/data";
final agenda = "$colletionDomain/agendamentos/data";
String horario = "Horário ainda não definido";

class CalendarioInterface extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

CollectionReference agendamentos =
    FirebaseFirestore.instance.collection(rotareserva);

agendarData(dataAlvo) {
  String dataAlvoString = dataAlvo.toString();

  var arr1 = dataAlvoString.split(' ');
  var domain1 = arr1[0];
  var dataRecebida = domain1.toString();
  //DateTime.now()

  String hojeString = DateTime.now().toString();

  var arr2 = hojeString.split(' ');
  var domain2 = arr2[0];
  var hoje = domain2.toString();

  Map<String, Object> dados = {
    'reserva': dataRecebida,
    'autor': user.email,
    'dominio': colletionDomain,
    'horario': horario
  };

  if (dataRecebida != hoje) {
    XrudSend(rotareserva, dataRecebida, dados);
    MaterialPageRoute(builder: (BuildContext context) => MyHomePage());
  }
}

class _HomeState extends State<CalendarioInterface> {
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
                  Text("Confirmar $dateTime - Horário - "),
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
                          .add(DateTime.parse(document.data()["reserva"]));
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
                      // locale: Locale("pt", "BR"),
                      theme: ThemeData(primarySwatch: Colors.blue),
                      styleDatePicker: MaterialRoundedDatePickerStyle(
                          textStyleDayOnCalendarDisabled: TextStyle(
                              fontSize: 16,
                              color: Colors.red) //.withOpacity(0.0)),

                          ),
                      /*textStyleDayOnCalendarDisabled: TextStyle(
                            fontSize: 28, color: Colors.white.withOpacity(0.1)),*/
                      imageHeader: AssetImage(
                        "assets/images/calendar_header_rainy.jpg",
                      ),
                      fontFamily: "Mali",
                      description: "Calendário para o horário: $horaString.",
                      listDateDisabled: diasCancelados,
                      textPositiveButton: "Confirmar",
                      textNegativeButton: "Cancelar",
                      customWeekDays: [
                        "DOM",
                        "SEG",
                        "TER",
                        "QUA",
                        "QUI",
                        "SEX",
                        "SAB"
                      ],
                    );
                    if (newDateTime != null) {
                      setState(() => dateTime = newDateTime);
                    }
                  },
                  label: const Text("Selecionar data"),
                ),

                const SizedBox(height: 12),

                FloatingActionButton.extended(
                  onPressed: () async {
                    TimeOfDay newTime = await showRoundedTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        leftBtn: "NOW",
                        onLeftBtn: () {
                          Navigator.of(context).pop(TimeOfDay.now());
                        });
                    if (newTime != null) {
                      setState(() {
                        dateTime = DateTime(
                          dateTime.year,
                          dateTime.month,
                          dateTime.day,
                          newTime.hour,
                          newTime.minute,
                        );
                        hora = DateTime(newTime.hour);
                        horaString = hora.toString(); //.split(' ');
                        horasplit = horaString.split('-');
                        horaString = horasplit[0].toString();
                      });
                    }
                  },
                  label: const Text("Selecione o horário"),
                ),
                const SizedBox(height: 12),

                FloatingActionButton.extended(
                  onPressed: () async {
                    horaString = hora.toString(); //.split(' ');
                    horasplit = horaString.split('-');
                    horario = horasplit[0].toString();
                    //horario = horario.substring(2);
                    agendarData("$dateTime");
                  },
                  label: const Text("Concluir reserva"),
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

class CalendarWithhourSelect extends StatefulWidget {
  @override
  _CalendarWithhourSelectState createState() => _CalendarWithhourSelectState();
}

class _CalendarWithhourSelectState extends State<CalendarWithhourSelect> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
