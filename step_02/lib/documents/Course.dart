import 'package:flutter/material.dart';

class Course {
  //Course id unique identifier
  String id;
  //The actual name of the course (ex: Intro to Languages)
  String name;
  //Get the prefix of the coursename (ex: ENG 400)
  String prefix;

  Course({@required this.id, this.name, this.prefix});

  //Factory method allowing us to read from json from firestore to a local object
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(id: json['id'], name: json['name'], prefix: json['prefix']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'prefix': prefix};
  }
}