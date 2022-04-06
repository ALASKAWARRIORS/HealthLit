import 'package:flutter/material.dart';

import 'modTwoQuiz.dart';

class modTwoGameWidget extends StatefulWidget{
  const modTwoGameWidget({Key key}) : super(key : key);

  @override
  modTwoGame createState() => modTwoGame();
}

class modTwoGame extends State<modTwoGameWidget>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Module 2"),
        backgroundColor: Colors.blue,
      ),

      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
                onPressed: () {startQuiz();},
                child: Text("Module 2 Quiz",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black
                ),),
            ),
          ],
        ),
      ),
    );
  }

  void startQuiz(){
    setState(() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> new modTwoQuiz()));
    });
  }
}