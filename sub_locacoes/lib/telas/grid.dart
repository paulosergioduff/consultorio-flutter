import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = "Lista no Grid";

    return MaterialApp(
        title: title,
        home: Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: GridView.count(
                crossAxisCount: 3,
                children: List.generate(opcoes.length, (index) {
                  return Center(
                    child: OpcaoCard(opcao: opcoes[index]),
                  );
                }))));
  }
}

class Opcao {
  const Opcao({this.titulo, this.icon});

  final String titulo;
  final IconData icon;
}

const List<Opcao> opcoes = const <Opcao>[
  const Opcao(titulo: 'Carro', icon: Icons.directions_car),
  const Opcao(titulo: 'Bike', icon: Icons.directions_bike),
  const Opcao(titulo: 'Barco', icon: Icons.directions_boat),
  const Opcao(titulo: 'Ônibux', icon: Icons.directions_bus),
  const Opcao(titulo: 'Trem', icon: Icons.directions_railway),
  const Opcao(titulo: 'Andar', icon: Icons.directions_walk),
  const Opcao(titulo: 'Carro', icon: Icons.directions_car),
  const Opcao(titulo: 'Bike', icon: Icons.drafts),
  const Opcao(titulo: 'Barco', icon: Icons.dvr),
  const Opcao(titulo: 'Copy', icon: Icons.copyright),
  const Opcao(titulo: 'Train', icon: Icons.cloud_off),
  const Opcao(titulo: 'Car', icon: Icons.directions_car),
  const Opcao(titulo: 'Bike', icon: Icons.directions_bike),
  const Opcao(titulo: 'Barco', icon: Icons.directions_boat),
  const Opcao(titulo: 'Ônibus', icon: Icons.directions_bus),
  const Opcao(titulo: 'Trem', icon: Icons.directions_railway),
  const Opcao(titulo: 'Andar', icon: Icons.directions_walk),
  const Opcao(titulo: 'Carro', icon: Icons.directions_car),
  const Opcao(titulo: 'Bike', icon: Icons.drafts),
  const Opcao(titulo: 'Barco', icon: Icons.dvr),
];

class OpcaoCard extends StatelessWidget {
  const OpcaoCard({Key key, this.opcao}) : super(key: key);
  final Opcao opcao;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
        color: Colors.white,
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(opcao.icon, size: 80.0, color: textStyle.color),
                Text(opcao.titulo, style: textStyle),
              ]),
        ));
  }
}
