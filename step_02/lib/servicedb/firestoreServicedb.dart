import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gtk_flutter/documents/Module.dart';

class FirestoreService
{
  FirebaseFirestore database = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  Stream<List<Module>> getModules()
  {
    return database
        .collection('User')
        .doc(firebaseUser.uid)
        .collection('modules')
        .snapshots()
        .map((snapshot) =>
    snapshot.docs.map((doc) => Module.fromJson(doc.data())).toList());
  }
}