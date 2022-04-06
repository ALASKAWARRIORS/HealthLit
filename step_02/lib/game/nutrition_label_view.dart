import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class nutrition_label_view extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return new nutrition_label_view_State();
  }
}

class nutrition_label_view_State extends State<nutrition_label_view>{
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nutrition Label"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
          child: InteractiveViewer(
            panEnabled: false, // Set it to false
            boundaryMargin: EdgeInsets.all(100),
            minScale: 0.5,
            maxScale: 2,
            child: Image.asset(
              'assets/nutrition_label_NVS.png',
              width: 300,
              height: 350,
              fit: BoxFit.cover,
            ),
          )
      )
    );
  }
}