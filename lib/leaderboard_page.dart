import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/color.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

Future<Map<String, dynamic>> fetchDailyTask() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception("Token tidak ditemukan. Harap login dulu.");
    }

    final response = await http.get(
      Uri.parse('http://192.168.101.231/api/daily-task'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal memuat data task harian: ${response.statusCode}');
    }
  } catch (e) {
    print("Error: $e");
    rethrow;
  }
}

int selectedIndex = 0;

class _LeaderboardPageState extends State<LeaderboardPage> {
  void loadDailyTask() async {
    try {
      final data = await fetchDailyTask();
      setState(() {
        answered = data['progress'];
        target = data['target'];
        progressValue = answered / target;
        isCompleted = data['is_completed'];
      });
    } catch (e) {
      print("Gagal memuat daily task: $e");
    }
  }

  double progressValue = 0.0;
  int answered = 0;
  int target = 0;
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: Column(
          children: [
            Text(
              'Leaderboard',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  // Container biru bergerak
                  AnimatedAlign(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    alignment: selectedIndex == 0
                        ? Alignment.centerLeft
                        : selectedIndex == 1
                        ? Alignment.center
                        : Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width / 4,
                        decoration: BoxDecoration(
                          color: icon,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Center(child: _buildTextOption('All time', 0)),
                      _buildTextOption('This Week', 1),
                      _buildTextOption('Month', 2),
                    ],
                  ),
                ],
              ),
            ),
            LinearProgressIndicator(
              value: progressValue,
              backgroundColor: Colors.white24,
              color: isCompleted ? Colors.greenAccent : Colors.orangeAccent,
              minHeight: 10,
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(height: 10),
            Text(
              "Progress: $answered / $target",
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextOption(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Text(
        text,
        style: TextStyle(
          color: selectedIndex == index ? Colors.white : Colors.black,
          fontWeight: selectedIndex == index
              ? FontWeight.bold
              : FontWeight.normal,
        ),
      ),
    );
  }
}
