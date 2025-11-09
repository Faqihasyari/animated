import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class QuizController extends GetxController {
  var quizzes = [].obs;
  var selectedAnswers = <int?>[].obs;
  var currentQuestionIndex = 0.obs;
  var selectedAnswerIndex = Rxn<int>();
  var correctAnswers = 0.obs;
  var userName = ''.obs; // dari login user
  var userRank = 0.obs; // bisa dari leaderboard, kalau ada

  // Progress
  var progress = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadQuizFromArguments();
  }

  void _loadQuizFromArguments() {
    // ✅ Ambil categoryName dari arguments
    final categoryName = Get.arguments as String?;
    if (categoryName != null) {
      fetchQuizzes(categoryName);
    } else {
      print("Error: Category name not provided in arguments");
    }
  }

  void checkAnswer(int selectedIndex) {
    // Hanya proses jika belum memilih sebelumnya
    if (selectedAnswerIndex.value != null) return;

    final currentQuestion = quizzes[0]['questions'][currentQuestionIndex.value];
    final answers = currentQuestion['answers'] as List;

    final correctIndex = answers.indexWhere(
      (a) => a['is_correct'] == 1 || a['is_correct'] == true,
    );

    if (selectedIndex == correctIndex) {
      correctAnswers.value++;
    }

    selectedAnswerIndex.value = selectedIndex;
  }

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
      Uri.parse(
        'http://192.168.53.231:8000/api/quizzes?category=$categoryToSend',
      ),
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
      selectedAnswerIndex.value =
          selectedAnswers.length > currentQuestionIndex.value
          ? selectedAnswers[currentQuestionIndex.value]
          : null;
    } else {
      await submitQuiz();
    }
  }

  // Kirim hasil quiz
  Future<void> submitQuiz() async {
    try {
      // ✅ Validasi data sebelum submit
      if (quizzes.isEmpty || quizzes[0]['questions'] == null) {
        print("No quiz data available");
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final userName = prefs.getString('user_name') ?? 'User';

      if (token == null) {
        print("User not logged in");
        Get.offAllNamed('/signin');
        return;
      }

      // ✅ Hitung score dengan validasi
      int correctCount = 0;
      final questions = quizzes[0]['questions'];

      for (int i = 0; i < questions.length; i++) {
        if (i < selectedAnswers.length && selectedAnswers[i] != null) {
          final answers = questions[i]['answers'] as List;
          final correctIndex = answers.indexWhere(
            (a) => a['is_correct'] == 1 || a['is_correct'] == true,
          );

          if (correctIndex != -1 && selectedAnswers[i] == correctIndex) {
            correctCount++;
          }
        }
      }

      // ✅ Submit ke API dengan timeout
      final response = await http
          .post(
            Uri.parse('http://192.168.53.231:8000/api/submit-quiz'),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'score': correctCount,
              'total': questions.length,
              'category': quizzes[0]['title'],
            }),
          )
          .timeout(const Duration(seconds: 10));

      int userRank = 0;
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        userRank = result['rank'] ?? 0;
        print('✅ Quiz submitted successfully. Rank: $userRank');
      } else {
        print('❌ Failed to submit quiz: ${response.statusCode}');
        Get.snackbar('Error', 'Gagal mengirim hasil quiz');
      }

      // ✅ NAVIGASI YANG AMAN - Clear stack dengan offAllNamed
      Get.offAllNamed(
        '/result',
        arguments: {
          'correctAnswers': correctCount,
          'totalQuestions': questions.length,
          'userName': userName,
          'userRank': userRank,
        },
      );
    } catch (e) {
      print('⚠️ Error submitting quiz: $e');

      // ✅ Fallback navigation dengan data lokal jika API error
      final questions = quizzes.isNotEmpty ? quizzes[0]['questions'] : [];
      Get.offAllNamed(
        '/result',
        arguments: {
          'correctAnswers': correctAnswers.value,
          'totalQuestions': questions.length,
          'userName': 'User',
          'userRank': 0,
        },
      );
    } finally {
      // ✅ Optional: Reset quiz state setelah submit
      // resetQuiz();
    }
  }
}
