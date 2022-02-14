import 'package:flutter/material.dart';

class Module
{
  String id;

  String name;

  bool isOpen;

  Module({ this.id, this.name, this.isOpen});

  factory Module.fromJson(Map<String, dynamic> json){
    return Module(id: json ['id'], name: json['name']);
  }
  Map<String, dynamic> toMap(){
    return{'id': id, 'name' : name};
  }

}