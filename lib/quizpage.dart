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
    final token = prefs.getString('token'); // 🔹 Ambil token dari local storage

    if (token == null) {
      print("Token belum ada, user belum login.");
      return;
    }

    final response = await http.get(
      Uri.parse(
        'http://localhost:8000/api/quizzes?category=${widget.categoryName}',
      ),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        quizzes = data;
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
              itemCount: quizzes.length,
              itemBuilder: (context, index) {
                final quiz = quizzes[index];
                return ListTile(
                  title: Text(quiz['title']),
                  subtitle: Text(quiz['description'] ?? ''),
                );
              },
            ),
    );
  }
}
