import 'package:flutter/material.dart';
import 'package:gtk_flutter/modTwoGameWidget.dart';

class foodChoiceQuiz{
  var pictures = [
    "mac_and_cheese_with_hot_dogs",
    "pepperoni_pizza",
    "chicken_nuggets_and_french_fries",
    "grilled_cheese",
    "quesadilla"
  ];

  var question = "What could you add to this meal in order for it to be balanced?";

  var choices = [
    ["Glass of milk", "Can of soda", "Baby carrots", "Fruit cup"],
    ["Carrot sticks and hummus", "Jello", "Fruit cup", "Cottage cheese"],
    ["Strawberries", "Can of soda", "Blueberries", "Sliced tomatoes"],
    ["Carrot sticks", "Fruit cup", "Sliced tomatoes", "Jello"],
    ["Tomato salsa", "Guacamole", "Cheese stick", "Can of soda"]
  ];

  var incorrectAnswers = [
    "Can of soda", "Jello", "Can of soda", "Jello", "Can of soda"
  ];
}

var questionNumber = 0;
var quiz = foodChoiceQuiz();

class modTwoQuiz extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return new modTwoQuizState();
  }
}

class modTwoQuizState extends State<modTwoQuiz>{
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: ()async => false,
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(20)),
              Container(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Question ${questionNumber + 1} of ${quiz.choices.length}",
                    style: TextStyle(
                      fontSize: 22
                    ),),
                  ]

                )
              ),
              Padding(padding: EdgeInsets.all(10)),
              Image.asset(
                  "assets/${quiz.pictures[questionNumber]}.jpg"
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(quiz.question,
                style: TextStyle(
                  fontSize: 20,
                ),),
              Padding(padding: EdgeInsets.all(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                      minimumSize: MaterialStateProperty.all(Size(120, 50)),
                      maximumSize: MaterialStateProperty.all(Size(120, 50)),
                    ),
                    onPressed: () {
                      if(quiz.choices[questionNumber][0] == quiz.incorrectAnswers[questionNumber]){

                        showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: Text("Try again"),
                                content: Text("This may not be the best option to add variety to create a balanced meal."),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context, "Ok"),
                                      child: Text("Ok")),
                                ],
                              );
                            }
                        );
                      }
                      else{
                        showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: Text("Excellent!"),
                                content: Text("Good Answer!"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, "Continue");
                                        questionNumber++;
                                        updateQuestion();
                                      },
                                      child: Text("Continue")),
                                ],
                              );
                            });
                      }
                    },
                    child: Text(quiz.choices[questionNumber][0],
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black
                      ),),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                      minimumSize: MaterialStateProperty.all(Size(120, 50)),
                      maximumSize: MaterialStateProperty.all(Size(120, 50)),
                    ),
                    onPressed: () {
                      if(quiz.choices[questionNumber][1] == quiz.incorrectAnswers[questionNumber]){

                        showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: Text("Try again"),
                                content: Text("This may not be the best option to add variety to create a balanced meal."),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context, "Ok"),
                                      child: Text("Ok")),
                                ],
                              );
                            }
                        );
                      }
                      else{
                        showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: Text("Excellent!"),
                                content: Text("Good Answer!"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, "Continue");
                                        questionNumber++;
                                        updateQuestion();
                                      },
                                      child: Text("Continue")),
                                ],
                              );
                            });
                      }
                    },
                    child: Text(quiz.choices[questionNumber][1],
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black
                      ),),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                      minimumSize: MaterialStateProperty.all(Size(120, 50)),
                      maximumSize: MaterialStateProperty.all(Size(120, 50)),
                    ),
                    onPressed: () {
                      if(quiz.choices[questionNumber][2] == quiz.incorrectAnswers[questionNumber]){

                        showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: Text("Try again"),
                                content: Text("This may not be the best option to add variety to create a balanced meal."),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context, "Ok"),
                                      child: Text("Ok")),
                                ],
                              );
                            }
                        );
                      }
                      else{
                        showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: Text("Excellent!"),
                                content: Text("Good Answer!"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, "Continue");
                                        questionNumber++;
                                        updateQuestion();
                                      },
                                      child: Text("Continue")),
                                ],
                              );
                            });
                      }
                    },
                    child: Text(quiz.choices[questionNumber][2],
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black
                      ),),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                      minimumSize: MaterialStateProperty.all(Size(120, 50)),
                      maximumSize: MaterialStateProperty.all(Size(120, 50)),
                    ),
                    onPressed: () {
                      if(quiz.choices[questionNumber][3] == quiz.incorrectAnswers[questionNumber]){

                        showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: Text("Try again"),
                                content: Text("This may not be the best option to add variety to create a balanced meal."),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context, "Ok"),
                                      child: Text("Ok")),
                                ],
                              );
                            }
                        );
                      }
                      else{
                        showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: Text("Excellent!"),
                                content: Text("Good Answer!"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, "Continue");
                                        questionNumber++;
                                        updateQuestion();
                                      },
                                      child: Text("Continue")),
                                ],
                              );
                            });
                      }
                    },
                    child: Text(quiz.choices[questionNumber][3],
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black
                      ),),
                  ),
                ],
              )
            ]
          )
        ),
      ),
    );
  }

  void resetQuiz(){
    setState(() {
      Navigator.pop(context);
      questionNumber = 0;
    });
  }

  void updateQuestion(){
    setState(() {
      if (questionNumber == quiz.choices.length) {
        resetQuiz();
        Navigator.push(context, MaterialPageRoute(builder: (context)=> modTwoGameWidget()));
      }
    });
  }
}