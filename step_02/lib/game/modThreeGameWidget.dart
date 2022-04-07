import 'package:flutter/material.dart';
import 'dosageChartView.dart';


class medicineQuestion{
  final int age;
  final int weight;
  String question = '';
  medicineQuestion(this.age, this.weight){
    this.question = questionBuilder(age, weight);
  }
}

String questionBuilder(int age, int weight){
  int yearConverter = 0;
  if (age >= 24){
    yearConverter = age ~/ 12;
    return 'Your child is ${yearConverter} year(s) old and weighs ${weight} lbs.';
  }
  return 'Your child is ${age} months(s) old and weighs ${weight} lbs.';
}

class modThreeGameWidget extends StatefulWidget{
  const modThreeGameWidget({Key key}) : super(key : key);

  @override
  modThreeGame createState() => modThreeGame();
}

var questionNumber = 0;

class modThreeGame extends State<modThreeGameWidget> {
  var questions = [
    medicineQuestion(2, 8),
    medicineQuestion(24, 30),
    medicineQuestion(36, 22),
    medicineQuestion(4, 15),
  ];
  var rating = 0.0;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Module 3'),
        backgroundColor: Colors.black,
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(10)),
              Text("Answer the following question using the slider at the bottom of the page "
                  "to get the proper medicine dosage for your child. "
                  "Use the chart below to help you solve each question. "
                  "You can tap on the chart below to zoom in to help you solve the questions"),
              Padding(padding: EdgeInsets.all(10)),
              Text(questions[questionNumber].question,
                style: TextStyle(
                    fontSize: 22
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Material(
                child: InkWell(
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => dosageChartView())),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset('assets/DosageTable_acetaminophen_table_sharp.jpg',
                        width: 350.0, height: 450.0),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text("Use the slider below in order to choose the appropriate answer",
                style: TextStyle(
                    fontSize: 16
                ),
              ),
              Slider(
                value: rating,
                min: 0,
                max: 5,
                onChanged: (newRating){
                  setState(() => rating = newRating);
                },
                divisions: 20,
                label: "$rating ml",
              ),
              ElevatedButton(
                  onPressed: (){
                    var isCorrect = checkAnswer(
                        questions[questionNumber].age,
                        questions[questionNumber].weight,
                        rating);
                    if (isCorrect){
                      rating = 0;
                      questionNumber++;
                      updateQuestion();
                      showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("Correct!"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, "Next");
                                    },
                                    child: Text("Next")),
                              ],
                            );
                          });
                    }
                    else{
                      showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("Try again"),
                              content: Text("This is not the correct answer."),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(context, "Ok"),
                                    child: Text("Ok")),
                              ],
                            );
                          }
                      );
                    }
                  },
                  child: Text("Check Answer")
              )
            ],
          ),
        ),
      )

    );
  }
  void updateQuestion(){
    setState(() {
      if (questionNumber == questions.length) {
        questionNumber = 0;
        Navigator.pop(context);
      }
    });
  }
}

bool checkAnswer(int age, int weight, double answer){
  var correct = false;

  if (weight >= 6 && weight <= 11){
    if (answer == 1.25){
      correct = true;
    }
  }
  else if(weight >= 12 && weight <= 17){
    if (answer == 2.5){
      correct = true;
    }
  }
  else if(weight >= 18 && weight <= 23){
    if (answer == 3.75){
      correct = true;
    }
  }
  else if(weight >= 24 && weight <= 35){
    if (answer == 5){
      correct = true;
    }
  }
  else if(weight >= 36 && weight <= 47){
    if (answer == 7.5){
      correct = true;
    }
  }
  else if(weight >= 48 && weight <= 59){
    if (answer == 10){
      correct = true;
    }
  }
  else if(weight >= 60 && weight <= 71){
    if (answer == 12.5){
      correct = true;
    }
  }
  else if(weight >= 72 && weight <= 95){
    if (answer == 15){
      correct = true;
    }
  }
  else if(weight >= 96){
    if (answer == 20){
      correct = true;
    }
  }

  return correct;
}