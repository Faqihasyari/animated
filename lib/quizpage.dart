import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

    final response = await http.get(
      Uri.parse(
        'http://192.168.120.231:8000/api/quizzes?category=${widget.categoryName}',
      ),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("Response for ${widget.categoryName}: $data");

      setState(() {
        quizzes = data; // langsung list
      });
    } else {
      print("Gagal mengambil quiz: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.categoryName} Quiz')),
      body: quizzes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: quizzes[0]['questions'].length,
              itemBuilder: (context, index) {
                final question = quizzes[0]['questions'][index];
                final answers = question['answers'] as List;

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${index + 1}. ${question['question_text']}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...answers.map(
                          (ans) => ListTile(
                            title: Text(ans['answer_text']),
                            leading: const Icon(Icons.circle_outlined),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
