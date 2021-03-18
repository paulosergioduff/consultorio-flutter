import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> XrudSend(collection, document, data) async {
  await FirebaseFirestore.instance
      .collection(collection)
      .doc(document)
      .set(data)
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}

Future<void> XrudDelete(collection, document) async {
  await FirebaseFirestore.instance
      .collection(collection)
      .doc(document)
      .delete();
  /*
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));*/
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