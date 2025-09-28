import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_essay.dart';

class QuizService {
  Future<List<QuizQuestion>> fetchQuestions() async {
    final url = Uri.parse(
      'https://opentdb.com/api.php?amount=10&category=18&difficulty=easy&type=multiple'
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'];
      return results.map((e) => QuizQuestion.fromJson(e)).toList();
    } else {
      throw Exception("Gagal ambil soal kuis");
    }
  }
}
