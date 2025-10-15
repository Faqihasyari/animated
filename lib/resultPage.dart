import 'package:flutter/cupertino.dart';

class Resultpage extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;
  final String userName;
  final int userRank;
  const Resultpage({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.userName,
    required this.userRank,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
