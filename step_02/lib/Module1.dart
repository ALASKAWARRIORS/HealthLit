import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gtk_flutter/Module.dart';
import 'package:gtk_flutter/main.dart';

import 'modOneGameWidget.dart';

class moduleOnePage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Module 1: Food'),
          leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => CoursePage()));
      //add page to home
    },
      child: Icon(Icons.home),
    )),

      //StreamBuilder receives the database response snapshot and allows us to extract data.
      body: Column(children: <Widget>[
      new StreamBuilder(
          stream: FirebaseFirestore.instance
          .collection('modules ')
          .doc('eOfMK0YpJzC6155hgl0J')
          .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
              child: CircularProgressIndicator(),
              );
            }
              var modDocument = snapshot.data;
              return new Text(modDocument['content'],
             style: TextStyle(fontSize: 18, fontFamily: 'Raleway'));
            }),
        RaisedButton(
          child: Text("Module 1 Game"),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => modOneGameWidget()),
          ),
        )
        ]));

  }
}