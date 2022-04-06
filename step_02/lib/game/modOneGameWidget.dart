import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import 'flashcard.dart';
import 'flashcardView.dart';


class modOneGameWidget extends StatefulWidget{
  const modOneGameWidget({Key key}) : super(key : key);

  @override
  modOneGame createState() => modOneGame();
}

class modOneGame extends State<modOneGameWidget> {

  List<Flashcard> flashcards = [
    Flashcard('What is a food group?', 'Category of foods that contain similar '
        'nutrients.'),
    Flashcard('How many servings of grains are recommended?', '6-11 of bread, '
        'cereal, rice, and pasta'),
    Flashcard('What food group has good sources of vitamins,'
        'minerals, and complex carbohydrates?',
        'Grains, make half your grains '
            'whole grain bread, cereal, rice, and pasta')
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Module 1'),
        ),

        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 250,
                    height: 250,
                    child: FlipCard(
                      front: FlashcardView(flashcards[currentIndex].question),
                      back: FlashcardView(flashcards[currentIndex].answer),
                    )
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton.icon(
                          onPressed: showPreviousCard,
                          icon: Icon(Icons.chevron_left),
                          label: Text("Prev")
                      ),
                      OutlinedButton.icon(
                          onPressed: showNextCard,
                          icon: Icon(Icons.chevron_right),
                          label: Text("Next")
                      )
                    ]
                )
              ],
            )
        )
    );
  }
  void showNextCard() {
    setState(() {
      currentIndex =
      (currentIndex + 1 < flashcards.length) ? currentIndex + 1 : 0;
    });
  }
  void showPreviousCard() {
    setState(() {
      currentIndex =
      (currentIndex - 1 >= 0) ? currentIndex - 1 : flashcards.length - 1;
    });
  }


}