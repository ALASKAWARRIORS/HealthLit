import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:gtk_flutter/servicedb/firestoreServicedb.dart';

import 'Course.dart';


class CourseProvider with ChangeNotifier {
  //Class private variables to be retrieved via getters
  final firestoreService = FirestoreService();
  String _name;
  String _prefix;


  //Getters
  String get name => _name;
  String get prefix => _prefix;

  Stream<List<Course>> get courses => firestoreService.getCourse();
}
