import 'package:flutter/material.dart';

final String globalMensagem = "Texto"

class MensagemNaTela extends StatefulWidget {
  @override
  _MensagemNaTelaState createState() => _MensagemNaTelaState();
}

class _MensagemNaTelaState extends State<MensagemNaTela> {
  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Mensagem do sistema'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  //Text('This is a demo alert dialog.'),
                  Text('$globalMensagem'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Approve'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
