import 'dart:async';

import 'package:custom_button_builder/custom_button_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/SignIn_page.dart';
import 'package:flutter_application_1/api_essay.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:flutter_application_1/kuis_service.dart';
import 'package:flutter_application_1/registe_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: RegistePage(), debugShowCheckedModeBanner: false);
  }
}

//ini buat kodingan splash scrennya
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff947EED),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset('assets/logo fix.png', scale: 4)],
        ),
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
  final TextEditingController _answerController = TextEditingController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _questions = _quizService.fetchQuestions();
  }

  void _checkAnswer(List<QuizQuestion> questions) {
    final userAnswer = _answerController.text.trim().toLowerCase();
    final correctAnswer = questions[_currentIndex].correctAnswer
        .trim()
        .toLowerCase();

    if (userAnswer == correctAnswer) {
      // kalau bener, lanjut soal berikutnya
      setState(() {
        if (_currentIndex < questions.length - 1) {
          _currentIndex++;
          _answerController.clear(); // kosongkan jawaban
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Kuis selesai 🎉")));
        }
      });
    } else {
      // kalau salah, kasih notifikasi
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Jawaban Anda"),
            content: const Text("Jawaban anda salah ❌"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
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
                  color: Colors.blueAccent[100],
                  border: Border.all(
                    color: const Color.fromARGB(97, 0, 0, 0),
                    width: 6,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Center(
                    child: Text(
                      q.question,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 25.0,
                  horizontal: 60,
                ),
                child: TextField(
                  controller: _answerController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Jawaban',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      // <- ini yang dipakai saat fokus
                      borderSide: BorderSide(color: Colors.black38, width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(5),
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              CustomButton(
                width: 100,
                backgroundColor: Colors.blue.shade200,
                isThreeD: true,

                height: 50,
                borderRadius: 5,
                animate: true,
                margin: const EdgeInsets.all(10),
                onPressed: () => _checkAnswer(questions),
                child: Text("JAWAB"),
              ),
            ],
          );
        },
      ),
    );
  }
}
