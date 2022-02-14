import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:gtk_flutter/documents/Module.dart';
import 'package:gtk_flutter/servicedb/firestoreServicedb.dart';
class moduledb with ChangeNotifier{
  final firestoreService = FirestoreService();
  String _name;

  String get name => _name;

  Stream<List<Module>> get modules => firestoreService.getModules();

}