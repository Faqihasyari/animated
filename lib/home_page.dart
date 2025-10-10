import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String userRank = '';
  String userName = '';
  var nameList = ['Football', 'Science', 'Fashion', 'Movie', 'Music'];
  var assetList = [
    'assets/Football.png',
    'assets/Science.png',
    'assets/Fashion.png',
    'assets/Movie.png',
    'assets/music.png',
  ];

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> submitAnswer(bool isCorrect) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      print('Token belum ada, user belum login');
      return;
    }

    final response = await http.post(
      Uri.parse('http://localhost:8000/api/quizzes/submit'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'is_correct': isCorrect}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Rank kamu sekarang: ${data['rank']}');

      // Simpan rank terbaru
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_rank', data['rank']);

      // Update tampilan
      setState(() {
        userRank = data['rank'];
      });
    } else {
      print('Gagal kirim jawaban: ${response.body}');
    }
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name') ?? '';
      userRank = prefs.getString('user_rank') ?? 'Beginner';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,

      body: Container(
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
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: CircleAvatar(
                      radius: 30,

                      backgroundImage: NetworkImage(
                        'https://media.istockphoto.com/id/2208884525/id/foto/permukaan-daun-dengan-tetesan-air-makro-dangkal-dofleaf-permukaan-dengan-tetesan-air-makro-dof.jpg?s=1024x1024&w=is&k=20&c=-tRdIPrCaNYembSMp4c0fvd9XKpKobrc4gNBH0t3y6M=',
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName.isNotEmpty
                            ? 'Halo, $userName 👋'
                            : 'Selamat datang di JDQuizz!',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        width: 55,
                        height: 25,
                        decoration: BoxDecoration(
                          border: BoxBorder.all(
                            color: Colors.white,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xffD9D9D9).withOpacity(0.5),
                        ),
                        child: Center(
                          child: Text(
                            userRank.isNotEmpty ? userRank : 'Beginner',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    width: 100,
                    height: 41,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://media.istockphoto.com/id/2208884525/id/foto/permukaan-daun-dengan-tetesan-air-makro-dangkal-dofleaf-permukaan-dengan-tetesan-air-makro-dof.jpg?s=1024x1024&w=is&k=20&c=-tRdIPrCaNYembSMp4c0fvd9XKpKobrc4gNBH0t3y6M=',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text('1200'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Container(
                width: double.infinity,
                height: 170,
                decoration: BoxDecoration(
                  color: containerColor.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: containerColor2.withOpacity(0.5),
                          ),
                          child: Image.asset('assets/container1.png'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tugas harian'),
                                SizedBox(height: 10),
                                Text('14 Soal'),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment(0.7, -0.7),
                            child: CircleAvatar(
                              child: Icon(Icons.access_time_filled_rounded),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Quiz',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'View All',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  nameList.length,
                  (index) => Column(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: containerQuiz.withOpacity(0.6),
                          border: Border.all(color: Colors.white, width: 0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Image.asset(assetList[index], scale: 2.5),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        nameList[index],
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'More Games',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'View All',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
