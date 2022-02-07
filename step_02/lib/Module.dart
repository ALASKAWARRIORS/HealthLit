import 'dart:async';
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';  // new
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:google_fonts/google_fonts.dart';

import 'package:gtk_flutter/main.dart';
import 'package:gtk_flutter/documents/Module.dart';

class ModulePage extends StatefulWidget
{
  ModulePage({required Key key}) : super(key: key);

  @override
  _ModulePageState createState() => _ModulePageState();
}
class _ModulePageState extends State<ModulePage>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modules'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Please select a following Module.",
                style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
            ),
            ),
            ),
            const ListTile(
              leading: Icon(Icons.event_note),
              title: Text('Module 1: Food Health Literacy')
            ),
            Row (
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  const SizedBox(width: 3),
                  TextButton(
                    child: const Text('Open'),
                    onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => Module(isOpen: true)),
                        );
                      },
                  ),
                  const SizedBox(width: 8),
                ],
            ),
            RaisedButton(
              child: Text("Home"),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AuthenticationWrapper()),

                );
              }),
          ],
        ),
      ),
    );
  }
}