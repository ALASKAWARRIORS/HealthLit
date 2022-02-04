import 'package:flutter/material.dart';

class FlashcardView extends StatelessWidget{
  final String text;

  FlashcardView(this.text, {Key? key}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        child: Center(
            child: Text(text, textAlign: TextAlign.center,)
        )
    );
  }
}