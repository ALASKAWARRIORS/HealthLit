import 'package:flutter/material.dart';

class Module
{
  String id;

  String name;

  Module({required this.id, required this.name});

  factory Module.fromJson(Map<String, dynamic> json){
    return Module(id: json ['id'], name: json['name']);
  }
  Map<String, dynamic> toMap(){
    return{'id': id, 'name' : name};
  }

}