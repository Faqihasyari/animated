import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const baseUrl =
      'http://192.168.98.231:8000/api'; // ganti sesuai platform

  // 🔹 Register
  static Future<http.Response> register(
    String name,
    String email,
    String password,
  ) {
    return http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );
  }

  // 🔹 Login
  static Future<http.Response> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']); // simpan token
    }

    return response;
  }

  // 🔹 Get Quizzes (dengan token)
  static Future<http.Response> getQuizzes() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    return http.get(
      Uri.parse('$baseUrl/quizzes'),
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  // 🔹 Logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {'Authorization': 'Bearer $token'},
    );
    await prefs.remove('token');
  }
}
