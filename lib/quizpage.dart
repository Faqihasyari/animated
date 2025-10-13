import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/color.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Quizpage extends StatefulWidget {
  final String categoryName;
  const Quizpage({super.key, required this.categoryName});

  @override
  State<Quizpage> createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {
  List quizzes = [];
  int currentQuestionIndex = 0; // 🔹 buat melacak pertanyaan aktif
  int? selectedAnswerIndex; // 🔹 simpan jawaban user

  @override
  void initState() {
    super.initState();
    fetchQuizzes(); // panggil pas halaman dibuka
  }

  Future<void> fetchQuizzes() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      print("Token belum ada, user belum login.");
      return;
    }

    // 🔹 Mapping antara kategori di Flutter dan nama di database Laravel
    Map<String, String> categoryMap = {
      'Football': 'Olahraga',
      'Science': 'Science',
      'Fashion': 'Fashion',
      'Movie': 'Film',
      'Music': 'Musik',
      'Geography': 'Geography',
      'Technology': 'Technology',
    };

    // 🔹 Konversi nama kategori Flutter ke nama di database
    String categoryToSend =
        categoryMap[widget.categoryName] ?? widget.categoryName;

    print("Kirim request untuk kategori: $categoryToSend");

    final response = await http.get(
      Uri.parse(
        'http://192.168.120.231:8000/api/quizzes?category=$categoryToSend',
      ),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("Response for ${widget.categoryName}: $data");

      setState(() {
        quizzes = data;
      });
    } else {
      print("Gagal mengambil quiz: ${response.body}");
    }
  }

  void nextQuestion() {
    if (currentQuestionIndex < quizzes[0]['questions'].length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswerIndex = null; // reset pilihan
      });
    } else {
      // Sudah pertanyaan terakhir
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Kuis selesai! 🎉")));
    }
  }

  @override
  Widget build(BuildContext context) {
    // 🔹 Cek apakah data belum siap
    if (quizzes.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // 🔹 Cek apakah tidak ada pertanyaan dalam quiz
    if (quizzes[0]['questions'] == null ||
        (quizzes[0]['questions'] as List).isEmpty) {
      return Scaffold(
        body: Center(
          child: Text(
            'Tidak ada pertanyaan di kategori ${widget.categoryName}',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.deepPurple,
      );
    }

    final currentQuestion = quizzes[0]['questions'][currentQuestionIndex];
    final answers = currentQuestion['answers'] as List;
    return Scaffold(
      // appBar: AppBar(title: Text('${widget.categoryName} Quiz')),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              radialGradient, // warna atas
              radialGradient2, // warna bawah
              radialGradient3,
              radialGradient4,
            ],
            center: Alignment.center, // posisi pusat gradient
            radius: 1.7, // semakin besar nilainya, semakin luas gradient-nya
            focal: Alignment.center, // titik fokus (opsional)
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    height: 850,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 300,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.black,
                          ),
                          child: Center(
                            child: Text(
                              currentQuestion['question_text'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // body: quizzes.isEmpty
      //     ? const Center(child: CircularProgressIndicator())
      //     : ListView.builder(
      //         itemCount: quizzes[0]['questions'].length,
      //         itemBuilder: (context, index) {
      //           final question = quizzes[0]['questions'][index];
      //           final answers = question['answers'] as List;

      //           return Card(
      //             margin: const EdgeInsets.all(8),
      //             child: Padding(
      //               padding: const EdgeInsets.all(12),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text(
      //                     '${index + 1}. ${question['question_text']}',
      //                     style: const TextStyle(
      //                       fontSize: 16,
      //                       fontWeight: FontWeight.bold,
      //                     ),
      //                   ),
      //                   const SizedBox(height: 8),
      //                   ...answers.map(
      //                     (ans) => ListTile(
      //                       title: Text(ans['answer_text']),
      //                       leading: const Icon(Icons.circle_outlined),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           );
      //         },
      //       ),
    );
  }
}
