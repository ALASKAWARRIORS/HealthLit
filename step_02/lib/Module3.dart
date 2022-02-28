import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gtk_flutter/main.dart';

import 'modThreeGameWidget.dart';



class moduleThreePage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Module 3: Medication Dosing')),
        //StreamBuilder receives the database response snapshot and allows us to extract data.
        body: Column(children: <Widget>[
          new StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('modules ')
                  .doc('DiYxOKwhrWy0Zv13mVxJ')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var modDocument = snapshot.data;
                return new Text("Module 3 " + "\n" + modDocument['content']);
              }),
          RaisedButton(
            child: Text("Module 3 Game"),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => modThreeGameWidget()),
            ),
          )
        ]));

  }
}