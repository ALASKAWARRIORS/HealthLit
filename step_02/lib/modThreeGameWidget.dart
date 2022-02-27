import 'package:flutter/material.dart';

class medicineQuestion{
  final double age;
  final int weight;
  String question = '';
  medicineQuestion(this.age, this.weight){
    this.question = 'Your child is ${age} year(s) old and weighs ${weight} lbs';
  }
}

class modThreeGameWidget extends StatefulWidget{
  const modThreeGameWidget({Key key}) : super(key : key);

  @override
  modThreeGame createState() => modThreeGame();
}

class modThreeGame extends State<modThreeGameWidget> {
  var questions = [
    medicineQuestion(2.5, 30),
    medicineQuestion(5, 45),
    medicineQuestion(6, 55),
    medicineQuestion(9, 62),
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Module 3'),
      ),
      body: Container(

      ),
    );
  }
}

bool checkAnswer(double age, int weight, double answer){
  var correct = false;

  if (weight >= 24 && weight <= 35){
    if (answer == 1){
      correct = true;
    }
  }
  else if(weight >= 36 && weight <= 47){
    if (answer == 1.5){
      correct = true;
    }
  }
  else if(weight >= 48 && weight <= 59){
    if (answer == 2){
      correct = true;
    }
  }
  else if(weight >= 60 && weight <= 71){
    if (answer == 2.5){
      correct = true;
    }
  }
  else if(weight >= 72 && weight <= 95){
    if (answer == 3){
      correct = true;
    }
  }
  return correct;
}