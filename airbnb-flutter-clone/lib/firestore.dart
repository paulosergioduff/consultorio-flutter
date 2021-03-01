import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUser extends StatelessWidget {
  final String fullName;
  final String company;
  final int age;

  AddUser(this.fullName, this.company, this.age);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user

      // Area de operação de CRUD (ABAIXO) <-- Verificar XRUD note
      return users
          .add({
            'full_name': fullName, // John Doe
            'company': company, // Stokes and Sons
            'age': age // 42
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
      // Area de operação CRUD (ACIMA) <-- Verificar XRUD note
    }

    return TextButton(
      onPressed: addUser,
      child: Text(
        "Add User",
      ),
    );
  }
}

class NewDocument extends StatelessWidget {
  final String documentId;

  NewDocument(this.documentId);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> newDocument() {
      // Call the user's CollectionReference to add a new user

      // Area de operação de CRUD (ABAIXO) <-- Verificar XRUD note
      return users
          .doc(documentId)
          .set({'full_name': "Mary Jane", 'age': 18})
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
      // Area de operação CRUD (ACIMA) <-- Verificar XRUD note
    }

    return TextButton(
      onPressed: newDocument,
      child: Text(
        "Add User",
      ),
    );
  }
}

class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Text("Full Name: ${data['full_name']} ${data['last_name']}");
        }

        return Text("loading");
      },
    );
  }
}

class DeleteDoc extends StatelessWidget {
  final String documentId;

  DeleteDoc(this.documentId);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> deleteDoc() {
      // Call the user's CollectionReference to add a new user

      // Area de operação de CRUD (ABAIXO) <-- Verificar XRUD note
      return users
          .doc(documentId)
          .delete()
          .then((value) => print("User Deleted"))
          .catchError((error) => print("Failed to delete user: $error"));
      // Area de operação CRUD (ACIMA) <-- Verificar XRUD note
    }

    return TextButton(
      onPressed: deleteDoc,
      child: Text(
        "Add User",
      ),
    );
  }
}

/*################ XRUD NOTE #################################

1) Adcionar documento (código automático)

return users
          .add({
            'full_name': fullName, // John Doe
            'company': company, // Stokes and Sons
            'age': age // 42
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));


2) Adcionar documento com nome

return users
    .doc('ABC123')
    .set({
      'full_name': "Mary Jane",
      'age': 18
    })
    .then((value) => print("User Added"))
    .catchError((error) => print("Failed to add user: $error"));


3) Atualizando campos de documento

return users
    .doc('ABC123')
    .update({'company': 'Stokes and Sons'})
    .then((value) => print("User Updated"))
    .catchError((error) => print("Failed to update user: $error"));

4) Apagando documentos

return users
    .doc('ABC123')
    .delete()
    .then((value) => print("User Deleted"))
    .catchError((error) => print("Failed to delete user: $error"));

5) Lendo usuário -> Estudar documentação dado ao número de opções. 
Classe de teste neste documento GetUserName


############################### FIM DA NOTAÇÃO XRUD #####################

*/
