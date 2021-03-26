import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sub_locacoes/apps/calendario/home.dart'; //oldname flutter_rounded_date_picker

void main() => runApp(CalendarioStart());

class CalendarioStart extends StatefulWidget {
  @override
  _CalendarioStartState createState() => _CalendarioStartState();
}

class _CalendarioStartState extends State<CalendarioStart> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale('en', 'US'),
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('th', 'TH'), // Thai
      ],
      home: Home(),
    );
  }
}
