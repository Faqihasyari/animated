import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  var userName = ''.obs;
  var userRank = 'Beginner'.obs;

  var answered = 0.obs;
  var target = 0.obs;
  var progressValue = 0.0.obs;
  var isCompleted = false.obs;

  var isLoading = true.obs;

  var questionCounts = <int>[].obs;
  var quizPoints = <int>[].obs;

  final String baseUrl = 'http://192.168.53.231:8000/api';

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    fetchDailyTask();
    fetchQuizData();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString('user_name') ?? '';
    userRank.value = prefs.getString('user_rank') ?? 'Beginner';
  }

  Future<void> fetchDailyTask() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) throw Exception("Token tidak ditemukan");

      final response = await http.get(
        Uri.parse('$baseUrl/daily-task'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        answered.value = data['progress'];
        target.value = data['target'];
        progressValue.value = answered.value / target.value;
        isCompleted.value = data['is_completed'];
      } else {
        print("Gagal load task: ${response.body}");
      }
    } catch (e) {
      print("Error daily task: $e");
    }
  }

  Future<void> fetchQuizData() async {
    try {
      isLoading.value = true;
      questionCounts.clear();
      quizPoints.clear();

      print("🔍 Fetching quizzes from API...");

      final response = await http.get(
        Uri.parse('http://19268.53.231:8000/api/quizzes'),
        headers: {'Content-Type': 'application/json'},
      );

      print("📊 Status Code: ${response.statusCode}");
      print("📊 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        print("📊 Decoded Response Type: ${decoded.runtimeType}");
        print("📊 Full Response: $decoded");

        // Handle berbagai struktur response
        List quizList = [];

        if (decoded is List) {
          quizList = decoded;
          print("✅ Response adalah List, jumlah quiz: ${quizList.length}");
        } else if (decoded is Map) {
          // Cek semua key yang ada di Map
          print("🔑 Keys in response: ${decoded.keys}");

          if (decoded.containsKey('data')) {
            quizList = decoded['data'] ?? [];
            print("✅ Response ada key 'data', jumlah quiz: ${quizList.length}");
          } else if (decoded.containsKey('quizzes')) {
            quizList = decoded['quizzes'] ?? [];
            print(
              "✅ Response ada key 'quizzes', jumlah quiz: ${quizList.length}",
            );
          } else if (decoded.containsKey('quiz')) {
            quizList = decoded['quiz'] ?? [];
            print("✅ Response ada key 'quiz', jumlah quiz: ${quizList.length}");
          } else {
            // Jika Map tapi tidak ada key yang dikenali, coba gunakan values
            quizList = decoded.values.toList();
            print("⚠️ Using Map values, jumlah: ${quizList.length}");
          }
        }

        if (quizList.isEmpty) {
          print("❌ Quiz list masih kosong setelah parsing");
          // Set default values untuk testing
          questionCounts.value = [
            10,
            15,
            8,
            12,
            10,
            10,
            15,
            8,
          ]; // Default values
          quizPoints.value = [100, 150, 80, 120, 100, 100, 150, 80];
          return;
        }

        print("📝 Processing ${quizList.length} quizzes...");

        // ✅ Extract data dengan detailed logging
        final counts = <int>[];
        final points = <int>[];

        for (var i = 0; i < quizList.length; i++) {
          final quiz = quizList[i];
          print("--- Quiz ${i + 1} ---");
          print("Quiz data: $quiz");

          // Question count
          final questions = quiz['questions'];
          print("Questions field: $questions");

          final questionCount = questions is List ? questions.length : 0;
          counts.add(questionCount);

          // Points - coba berbagai kemungkinan field name
          final maxPoints =
              quiz['max_points'] ??
              quiz['points'] ??
              quiz['reward_points'] ??
              quiz['coins'] ??
              0;
          points.add(maxPoints is int ? maxPoints : 0);

          print("📝 Quiz ${i + 1}: $questionCount soal, $maxPoints poin");
        }

        questionCounts.value = counts;
        quizPoints.value = points;

        print('✅ Final - Jumlah soal per quiz: $questionCounts');
        print('✅ Final - Poin per quiz: $quizPoints');
      } else {
        print('❌ Gagal fetch quiz: ${response.statusCode} - ${response.body}');
        // Set default values untuk testing
        questionCounts.value = [10, 15, 8, 12, 10, 10, 15, 8];
        quizPoints.value = [100, 150, 80, 120, 100, 100, 150, 80];
      }
    } catch (e) {
      print('⚠️ Error ambil data: $e');
      // Set default values untuk testing
      questionCounts.value = [10, 15, 8, 12, 10, 10, 15, 8];
      quizPoints.value = [100, 150, 80, 120, 100, 100, 150, 80];
    } finally {
      isLoading.value = false;
    }
  }
}
