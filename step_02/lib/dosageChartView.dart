import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class dosageChartView extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return new dosageChartViewState();
  }
}

class dosageChartViewState extends State<dosageChartView>{
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dosage Chart"),
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
                'assets/DosageTable_acetaminophen_table_sharp.jpg',
                width: 300,
                height: 350,
                fit: BoxFit.cover,
              ),
            )
        )
    );
  }
}