import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sub_locacoes/apps/slider.dart';

import 'package:sub_locacoes/engine/xrud.dart';
import 'package:sub_locacoes/home.dart';

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

class SalaInterface extends StatefulWidget {
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
    MaterialPageRoute(builder: (BuildContext context) => SubLocacoes());
  }
}

higienizaData(dataAlvoString) {
  var arr1 = dataAlvoString.split(' ');
  var domain1 = arr1[0];
  var dataRecebida = domain1.toString();

  return dataRecebida;
}

agendarEmMassa(dataAlvo) {
  String dataAlvoString = dataAlvo.toString();

  var arr1 = dataAlvoString.split(' ');
  var domain1 = arr1[0];
  var dataRecebida = domain1.toString();
  //DateTime.now()

  String hojeString = DateTime.now().toString();

  var arr2 = hojeString.split(' ');
  var domain2 = arr2[0];
  var hoje = domain2.toString();

  //var status = null;

  var status = higienizaData(dataRecebida); // Serve apenas 1 vez antes do loop
  Map<String, Object> dados = {
    'reserva': status,
    'autor': user.email,
    'dominio': colletionDomain,
    'horario': horario
  };

  XrudSend(rotareserva, status, dados);

  if (dataRecebida != hoje) {
    for (var i = 1; i < 3; i++) {
      var alvo = DateTime.parse(status);
      var alvoplus = alvo.add(Duration(days: 7));
      var alvoString = alvoplus.toString();
      var alvofinal = higienizaData(alvoString).toString();
      status = alvofinal;

      Map<String, Object> dados = {
        'reserva': alvofinal,
        'autor': user.email,
        'dominio': colletionDomain,
        'horario': horario
      };

      XrudSend(rotareserva, alvofinal, dados);
    }
  }
}

class _HomeState extends State<SalaInterface> {
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
              ],
            ),
          ),
          CarouselWithIndicatorDemo(),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Salas'),
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
