
import 'package:flutter/material.dart';
import 'package:gtk_flutter/main.dart';

import 'NVSTestOneWidget.dart';

class moduleZeroPage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('NVS Test'),
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
        body: Center(
            child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text("Please Complete the following The Newest Vital Sign Test",
                    style: TextStyle(fontSize: 18, fontFamily: 'Raleway')),
              ),

          RaisedButton(
            child: Text("NVS Test"),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NVSTestOneWidget()),
            ),
          )
        ])));

  }
}