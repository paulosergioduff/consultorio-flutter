import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sub_locacoes/services/services-main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

final FirebaseAuth _auth = FirebaseAuth.instance;
final User user = _auth.currentUser;
final String emailUser = user.email;

String domain = setDomain(emailUser).toString();

DateTime instancia = DateTime.now();
String saida = instancia.toString();

final String relatDocument = emailUser + '-' + saida;

final String colletionDomain = domain;

Future<void> geraRelatIn(data, collection) async {
  var base64Str = base64.encode(collection); // Caminho original da coleção
  var mountAdress = relatDocument + "@" + base64Str;
  await FirebaseFirestore.instance
      .collection("entrada")
      .doc(mountAdress)
      .set(data)
      .then((value) => print("system in"))
      .catchError((error) => print("Failed to add user: $error"));
}

Future<void> geraRelatOut(document, collection) async {
  var base64Str = base64.encode(collection);
  var mountAdress = relatDocument + base64Str + "@" + document;
  var path = relatDocument + "@" + base64Str;

  Map<String, Object> dados = {
    'file': document,
    'collection': collection,
    "log": relatDocument,
    "path": path,
    "autor": emailUser
  };

  await FirebaseFirestore.instance
      .collection("saida")
      .doc(mountAdress)
      .set(dados)
      .then((value) => print("system out"))
      .catchError((error) => print("Failed to add user: $error"));
}

Future<void> XrudSend(collection, document, data) async {
  geraRelatOut(document, collection);
  await FirebaseFirestore.instance
      .collection(collection)
      .doc(document)
      .set(data)
      .then((value) => geraRelatIn(data, collection))
      .catchError((error) => print("Failed to add user: $error"));
}
//Map<String, Object> dados = {'full_name': "Mary novidade", 'age': 18};

Future<void> XrudDelete(collection, document) async {
  geraRelatOut(document, collection);
  await FirebaseFirestore.instance
      .collection(collection)
      .doc(document)
      .delete()
      .then((value) => geraRelatOut(document, collection))
      .catchError((error) => print("Failed to add user: $error"));
}

Future<dynamic> XrudRead(collection, document) async {
  await FirebaseFirestore.instance
      .collection(collection)
      .doc(document)
      .get()
      .then((DocumentSnapshot ds) {
    //String username = ds["name"];
    return ds;
  });
}

/*
Future<String> XrudRead(collection, document) async {
  String result;
  FirebaseFirestore.instance
      .collection(collection)
      .doc(document)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      print('Document data: ${documentSnapshot.data()}');
      result = '${documentSnapshot.data()}';
    } else {
      print('Document does not exist on the database');
      result = 'Fail';
    }

    return result;
  });
  /*
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));*/
}

*/

/*
Future<void> XrudDelete(collection, document) async {
  await FirebaseFirestore.instance
      .collection(collection)
      .document(document)
      .delete();
}
*/
