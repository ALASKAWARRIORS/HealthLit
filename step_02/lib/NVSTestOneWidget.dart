import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'calculatorWidget.dart';
import 'nutrition_label_view.dart';

class NVSTestOne{

  var questions = [
        "If you eat the entire container of ice cream how many calories will "
        "you eat?",
  "If you are allowed to eat 60 grams of carbohydrates as a snack, "
        "how much ice cream can you have?",
  "Your doctor advises you to reduce the amount of saturated fat in your diet."
        " You usually have 42 g of saturated fat each day, which includes one "
        "serving of ice cream. If you stop eating ice cream, how many grams of "
        "saturated fat would you be eating each day?",
  "If you usually eat 2,500 calories in a day, what percentage of your daily "
      "value of calories will you be eating if you eat one serving?",
    "Pretend that you are allergic to the following substances: penicillin, "
        "peanuts, latex gloves and bee stings.\n"
        "Is it safe for you to eat this ice cream?",
    "Why not?"
  ];

  var choices = [
    ["250 Calories", "500 Calories", "750 Calories", "1000 Calories", "I do not know"],
    ["1/2 cup (1 serving)", "1 cup (2 servings)", "2 cups (4 servings)", "I do not know"],
    ["0 grams", "9 grams", "33 grams", "39 grams", "I do not know"],
    ["5%", "10%", "25%", "I do not know"],
    ["YES", "NO", "I do not know"],
    ["Contains peanut or peanut oil", "Comes from bees", "Contains macadamia nuts", "I do not know"]
  ];

  var correctAnswers = [
    "1000 Calories", "1 cup (2 servings)", "33 grams", "10%", "NO", "Contains peanut or peanut oil"
  ];
}

class NVSTestOneWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return new NVSTestOneWidgetState();
  }
}
var _value = 0;
var questionNumber = 0;
var correctAnswers = 0;
var test = NVSTestOne();

class NVSTestOneWidgetState extends State<NVSTestOneWidget>{
  @override
  Widget build(BuildContext context) {

    return new WillPopScope(
      onWillPop: ()async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('NVS Test 1'),
          backgroundColor: Colors.black,
        ),
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(15)),
                  Text("This Nutrition Facts label is on the back of the pint "
                      "of ice cream. Tap the image to zoom in.",
                    style: TextStyle(
                      fontSize: 18,
                    ),),
                  Padding(padding: EdgeInsets.all(10)),
                  Material(
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => nutrition_label_view())),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset('assets/nutrition_label_NVS.png',
                            width: 300.0, height: 350.0),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  ElevatedButton(
                      onPressed: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context)=> calculatorWidget()));
                      },
                      child: Text("Calculator")),
                  Padding(padding: EdgeInsets.all(10)),
                  Text(test.questions[questionNumber],
                    style: TextStyle(
                      fontSize: 18,
                    ),),
                  Padding(padding: EdgeInsets.all(10)),
                  for (int i = 0; i < test.choices[questionNumber].length; i++)
                    ListTile(
                      title: Text(
                        '${test.choices[questionNumber][i]}',
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: Colors.black,
                            fontSize: 15),
                      ),
                      leading: Radio(
                        value: i,
                        groupValue: _value,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        activeColor: Colors.blue,
                        onChanged: (int value) {
                          setState(() {
                            _value = value;
                          });
                        },
                      ),
                    ),
                ElevatedButton(
                    onPressed: (){
                      if (test.choices[questionNumber][_value] == test.correctAnswers[questionNumber]) {
                        correctAnswers++;
                        questionNumber++;
                      }
                      // Skips the last question if they got question 5 wrong
                      else if (questionNumber == 4) {
                        questionNumber = 0;
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> NVSTestOneResultsWidget()));
                      }
                      else {
                        questionNumber++;
                      }
                      updateQuestion();
                    },
                    child: Text("Next"))
                ],
              ),
            ),

          ),
      ),
    );
  }
  void updateQuestion(){
    setState(() {
      if (questionNumber == test.choices.length) {
        questionNumber = 0;
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> NVSTestOneResultsWidget()));
      }
    });
  }
}

class NVSTestOneResultsWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return new NVSTestOneResultsWidgetState();
  }
}

class NVSTestOneResultsWidgetState extends State<NVSTestOneResultsWidget>{
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: ()async => false,
        child: Scaffold(
          appBar: AppBar(
            title: Text('NVS Test 1'),
            backgroundColor: Colors.black,
          ),
          body: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(10)),
                Text("${correctAnswers} out of ${test.questions.length} correct",
                    style: TextStyle(
                        fontSize: 22
                    )),
                ElevatedButton(
                    onPressed: (){
                      correctAnswers = 0;
                      Navigator.pop(context);
                    },
                    child: Text("Exit",
                    style: TextStyle(
                      fontSize: 22,
                    ),),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      minimumSize: MaterialStateProperty.all(Size(120, 50))
                    ))
              ],
            ),
          ),
        ));
  }

}
