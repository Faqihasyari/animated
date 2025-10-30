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

  var questionCounts = <int>[].obs;
  var quizPoints = <int>[].obs;

  final String baseUrl = 'http://192.168.101.231:8000/api';

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
      final response = await http.get(Uri.parse('$baseUrl/quizzes'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        questionCounts.value =
            List<int>.from(data.map((q) => q['questions']?.length ?? 0));
        quizPoints.value =
            List<int>.from(data.map((q) => q['max_points'] ?? 0));
      } else {
        print("Gagal fetch quiz: ${response.body}");
      }
    } catch (e) {
      print("Error quiz data: $e");
    }
  }
}
