import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class QuizController extends GetxController {
  var quizzes = [].obs;
  var selectedAnswers = <int?>[].obs;
  var currentQuestionIndex = 0.obs;
  var selectedAnswerIndex = Rxn<int>();

  // Progress
  var progress = 0.0.obs;

  // Load quiz berdasarkan kategori
  Future<void> fetchQuizzes(String categoryName) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      print("Token belum ada, user belum login.");
      return;
    }

    Map<String, String> categoryMap = {
      'Football': 'Olahraga',
      'Science': 'Science',
      'Fashion': 'Fashion',
      'Movie': 'Film',
      'Music': 'Musik',
      'Geography': 'Geography',
      'Technology': 'Technology',
      'Quiz Sejarah': 'Sejarah',
    };

    String categoryToSend = categoryMap[categoryName] ?? categoryName;

    final response = await http.get(
      Uri.parse('http://192.168.101.231:8000/api/quizzes?category=$categoryToSend'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      quizzes.value = data;
    } else {
      print("Gagal mengambil quiz: ${response.body}");
    }
  }

  // Navigasi ke soal berikutnya
  void nextQuestion() async {
    if (selectedAnswers.length <= currentQuestionIndex.value) {
      selectedAnswers.add(selectedAnswerIndex.value);
    } else {
      selectedAnswers[currentQuestionIndex.value] = selectedAnswerIndex.value;
    }

    if (currentQuestionIndex.value < quizzes[0]['questions'].length - 1) {
      currentQuestionIndex.value++;
      selectedAnswerIndex.value = selectedAnswers.length > currentQuestionIndex.value
          ? selectedAnswers[currentQuestionIndex.value]
          : null;
    } else {
      await submitQuiz();
    }
  }

  // Kirim hasil quiz
  Future<void> submitQuiz() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final userName = prefs.getString('user_name') ?? 'User';

    int correctCount = 0;
    for (int i = 0; i < quizzes[0]['questions'].length; i++) {
      final answers = quizzes[0]['questions'][i]['answers'];
      final correctIndex = answers.indexWhere((a) => a['is_correct'] == 1);
      if (selectedAnswers[i] == correctIndex) {
        correctCount++;
      }
    }

    final response = await http.post(
      Uri.parse('http://192.168.101.231:8000/api/submit-quiz'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'score': correctCount,
        'total': quizzes[0]['questions'].length,
        'category': quizzes[0]['title'],
      }),
    );

    int userRank = 0;
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      userRank = result['rank'] ?? 0;
    }

    // Navigasi ke halaman hasil
    Get.toNamed('/result', arguments: {
      'correctAnswers': correctCount,
      'totalQuestions': quizzes[0]['questions'].length,
      'userName': userName,
      'userRank': userRank,
    });
  }
}
