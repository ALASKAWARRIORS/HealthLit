import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'widgets.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth;

  Authentication(this._firebaseAuth);

  Stream<User> get authStateChange => _firebaseAuth.idTokenChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> signIn({ String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp({ String email,String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}

