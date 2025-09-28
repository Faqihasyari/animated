import 'package:flutter/material.dart';
import 'package:flutter_application_1/api_essay.dart';
import 'package:flutter_application_1/kuis_service.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyQuiz());
  }
}

class QuizPage extends StatefulWidget {
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final QuizService _quizService = QuizService();
  late Future<List<QuizQuestion>> _questions;

  @override
  void initState() {
    super.initState();
    _questions = _quizService.fetchQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kuis Flutter")),
      body: FutureBuilder<List<QuizQuestion>>(
        future: _questions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Tidak ada soal"));
          }

          final questions = snapshot.data!;
          return ListView.builder(
            itemCount: questions.length,
            itemBuilder: (context, index) {
              final q = questions[index];
              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text(q.question),
                  subtitle: Text("Jawaban: ${q.correctAnswer}"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class MyQuiz extends StatefulWidget {
  const MyQuiz({super.key});

  @override
  State<MyQuiz> createState() => _MyQuizState();
}

class _MyQuizState extends State<MyQuiz> {
  final QuizService _quizService = QuizService();
  late Future<List<QuizQuestion>> _questions;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _questions = _quizService.fetchQuestions();
  }

  void _nextQuestion(List<QuizQuestion> questions) {
    setState(() {
      if (_currentIndex < questions.length - 1) {
        _currentIndex++;
      } else {
        // kalau sudah terakhir, bisa tampilkan skor atau selesai
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Kuis selesai 🎉")));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<QuizQuestion>>(
        future: _questions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Tidak ada soal"));
          }
          final questions = snapshot.data!;
          final q = questions[_currentIndex];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Center(child: Text(q.question)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 25.0,
                  horizontal: 60,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
