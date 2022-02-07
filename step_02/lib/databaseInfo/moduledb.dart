import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:gtk_flutter/documents/Module.dart';
import 'package:gtk_flutter/servicedb/firestoreServicedb.dart';
class moduledb with ChangeNotifier{
  final firestorService = FirestoreService();
  late String _name;
  late String _id;

  String get name => _name;

  Stream<List<Module>> get modules => firestorService.getModules();

}