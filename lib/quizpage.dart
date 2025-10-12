import 'package:flutter/cupertino.dart';

class Quizpage extends StatefulWidget {
   final String categoryName;
  const Quizpage({super.key, required this.categoryName});

  @override
  State<Quizpage> createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}