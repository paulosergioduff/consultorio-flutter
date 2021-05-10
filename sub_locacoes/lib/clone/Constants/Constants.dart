import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sub_locacoes/clone/Model/Address.dart';
import 'package:sub_locacoes/clone/Model/NewRoom.dart';
import 'package:sub_locacoes/clone/Model/Property.dart';
import 'package:sub_locacoes/clone/Model/Wilaya.dart';
import 'package:sub_locacoes/clone/Model/Appartement.dart';

String texto = ""; // Texto para editar informações

class Constants {
  static List<Property> properties = [
    NewRoom(
      "NewRoom",
      ['assets/images/properties/p1.jpg', "assets/images/properties/p2.jpg"],
      5000,
      Address("Label1", "String1", "Title1", "NewRoom1", "num15", "num09025"),
      "As mais pedidas da programação ",
      4.2,
      Commodite(true, true, false, true, true, true, true, true, true),
      true,
      false,
      true,
    ),
    appartement(
      "appartement",
      ['assets/images/properties/p1.jpg', "assets/images/properties/p2.jpg"],
      2500,
      Address(
          "Label2", "String2", "Title2", "Appartment2", "num55", "num16025"),
      "O aplicativo que mais cresce no Brasil ",
      4.0,
      Commodite(true, true, false, true, true, true, true, true, true),
      true,
      false,
      true,
    ),
  ];

  static List<Wilaya> wilayas = [
    Wilaya("Alger", 16, "Ville sur plage avec des monuments touristiques",
        "assets/images/properties/p1.jpg"),
    Wilaya("Oran", 31, "Ville sur plage avec des monuments touristiques",
        "assets/images/properties/p2.jpg"),
    Wilaya("Blida", 09, "Ville avec des monuments touristiques et forets",
        "assets/images/properties/p3.jpg"),
    Wilaya("Gherdaia", 47, "Ville du sahara avec des monuments historiques",
        "assets/images/properties/p4.jpg"),
  ];

  static Color redAirbnb = Color(0xff6d63ea);
  static Color greenAirbnb = Color(0xFF6d63ea); //Colors.purple;
}

class MinhasSalas {
  static List<Property> properties = [
    NewRoom(
      "NewRoom",
      ['assets/images/properties/p1.jpg', "assets/images/properties/p2.jpg"],
      5000,
      Address("Label1", "String1", "Title1", "NewRoom1", "num15", "num09025"),
      "As mais pedidas da programação ",
      4.2,
      Commodite(true, true, false, true, true, true, true, true, true),
      true,
      false,
      true,
    ),
    appartement(
      "appartement",
      ['assets/images/properties/p1.jpg', "assets/images/properties/p2.jpg"],
      2500,
      Address(
          "Label2", "String2", "Title2", "Appartment2", "num55", "num16025"),
      "O aplicativo que mais cresce no Brasil ",
      4.0,
      Commodite(true, true, false, true, true, true, true, true, true),
      true,
      false,
      true,
    ),
  ];

  static List<Wilaya> wilayas = [
    Wilaya("Alger", 16, "Ville sur plage avec des monuments touristiques",
        "assets/images/properties/p1.jpg"),
    Wilaya("Oran", 31, "Ville sur plage avec des monuments touristiques",
        "assets/images/properties/p2.jpg"),
    Wilaya("Blida", 09, "Ville avec des monuments touristiques et forets",
        "assets/images/properties/p3.jpg"),
    Wilaya("Gherdaia", 47, "Ville du sahara avec des monuments historiques",
        "assets/images/properties/p4.jpg"),
  ];

  static Color redAirbnb = Color(0xff6d63ea);
  static Color greenAirbnb = Color(0xFF6d63ea); //Colors.purple;
}
