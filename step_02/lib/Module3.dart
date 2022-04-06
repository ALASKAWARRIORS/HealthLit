import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gtk_flutter/main.dart';

import 'game/modThreeGameWidget.dart';

class moduleThreePage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Module 3: Medication Dosing'),
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
        body: SingleChildScrollView(
            child: Column(
                children: <Widget>[
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
                return new Text(modDocument['content'],
                    style: TextStyle(fontSize: 18, fontFamily: 'Raleway'));
              }),
          RaisedButton(
            child: Text("Module 3 Game"),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => modThreeGameWidget()),
            ),
          )
        ])));

  }
}