import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gtk_flutter/documents/Course.dart';

class FirestoreService
{
  FirebaseFirestore database = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  Stream<List<Course>> getCourse()
  {
    return database
        .collection('User')
        .doc(firebaseUser.uid)
        .collection('modules')
        .snapshots()
        .map((snapshot) =>
    snapshot.docs.map((doc) => Course.fromJson(doc.data())).toList());
  }
}