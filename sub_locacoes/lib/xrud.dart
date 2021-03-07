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

class ReadDemo extends StatelessWidget {
  final String documentId;
  final String collection;

  ReadDemo(this.collection, this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection(collection);

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Text("Full Name: ${data['full_name']} age: ${data['age']}");
        }

        return Text("loading");
      },
    );
  }
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