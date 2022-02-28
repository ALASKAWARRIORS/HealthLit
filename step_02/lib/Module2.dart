import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'modTwoGameWidget.dart';

class moduleTwoPage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Module 2: Nutrition')),
        //StreamBuilder receives the database response snapshot and allows us to extract data.
        body: Column(children: <Widget>[
          new StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('modules ')
                  .doc('ENisXDMhBUcb5ps4hXs9')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var modDocument = snapshot.data;
                return new Text("Module 2 " + "\n"+ modDocument['content']);
              }),
          RaisedButton(
            child: Text("Module 2 Game"),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => modTwoGameWidget()),
            ),
          )
        ]));

  }
}