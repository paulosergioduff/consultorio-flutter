import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class Sair {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// Example code for sign out.
  Future<void> _signOut() async {
    await _auth.signOut();

    MaterialPageRoute(builder: (context) => MyApp());
  }
}
