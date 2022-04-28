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
            'whole grain bread, cereal, rice, and pasta'),
    Flashcard('What nutrients are Grains a good source of?','Fiber, iron, and vitamin B.'),
    Flashcard('How many servings of vegetables are recommended?','3-5 cups'),
    Flashcard('What food group has good sources of vitamins A and C and minerals?', 'Vegetable group.'),
    Flashcard('What are starchy vegetables (potatoes) a good source of?', 'Complex carbohydrates and fiber.'),
    Flashcard('How many servings of fruits are recommended?', '2-4 cups'),
    Flashcard('What food group has good sources of vitamins A and C, potassium, and carbohydrates?', 'Fruit group. Make half your fruit whole fruits.'),
    Flashcard('Fruit skins also provide what?', 'Fiber'),
    Flashcard('How many servings of milk, yogurt, and cheese recommended?', '2-3'),
    Flashcard('What food group has good sources of calcium, vitamin D and protein?', 'Dairy group (Milk, yogurt and cheese)'),
    Flashcard('How much food, in ounces, from the Protein group recommended?', '4 to 6 ounces'),
    Flashcard('What food group has good sources of protein, vitamin B, iron, and zinc?', 'Protein group.'),
    Flashcard('In the Protein group, what version can help limit fat intake?', 'Lean meats, seafood and beans.'),
    Flashcard('How much of the, fats, oils, and sweets group is recommended?', 'Limited.'),
    Flashcard('What is MyPlate?', 'A visual icon that tells how many servings from each food group are recommended each day.'),
    Flashcard('What is involved in a balanced diet?', 'Servings of foods from different food groups.'),
    Flashcard('What is a serving?', 'Specific amount of food that is indicated on the nutrition label or as listed on ChooseMyPlate.gov'),
    Flashcard('What are some of the factors to find out the number of servings that is right for you?', 'Your age, gender, size, and how active you are.'),
    Flashcard('What is the suggested caloric intake level for most children, teenage girls, active women, and many sedentary men?', '2200 calories.'),
    Flashcard('What is the suggested caloric intake level for teenage boys, many active men, and some very active women?', '2800 calories.'),
    Flashcard('What are Dietary Guidelines? How were they created?', 'Recommendations for diet choices among healthy Americans who are two years of age or older. They are a result of research done by the USDA (U.S. Department of Agriculture) and USDHHS (U.S. Department of Health and Human Services)'),
    Flashcard('What are some of the Dietary Guidelines?', 'Eat a variety of foods, balance food with physical activity, choose a diet low in fat, saturated fat, choose a diet with plenty of lean protein, low-fat dairy, whole grain products, vegetables, and fruits, choose a diet moderate in sugars, salt, and sodium, do not drink alcohol, or drink moderately.'),
    Flashcard('What is saturated fat?', 'A type of fat found in dairy products, solid vegetable fat, and meat/poultry.'),
    Flashcard('What is cholesterol?', 'A fat-like substance made by the body and found in certain foods.'),
    Flashcard('What is sodium?', 'A mineral food in table salt and prepared foods.'),
    Flashcard('What is a vegetarian diet?', 'A diet in which vegetables are the foundation. Meat, fish, and poultry are restricted and/or eliminated.'),
    Flashcard('What is a vegan diet?', 'A diet that excludes foods of animal origin. No dairy or eggs are allowed.'),
    Flashcard('What is a lacto-vegetarian diet?', 'A diet that excludes meat, fish, eggs and poultry. Can have dairy.'),
    Flashcard('What is an ovo-lacto-vegetarian diet?', 'A diet that excludes red meat, fish, and poultry. Can have eggs and dairy.')
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