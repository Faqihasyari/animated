import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // ✅ tambahkan ini

import 'package:flutter_application_1/SignIn_page.dart';
import 'package:flutter_application_1/bottom_nav.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:flutter_application_1/leaderboard_page.dart';
import 'package:flutter_application_1/registe_page.dart';

// kalau sudah buat folder GetX (controllers, views, bindings)
import 'package:flutter_application_1/app/modules/home/bindings/home_binding.dart';
import 'package:flutter_application_1/app/modules/home/views/home_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // ✅ ubah dari MaterialApp → GetMaterialApp
      debugShowCheckedModeBanner: false,
      initialBinding: HomeBinding(), // ✅ supaya controller otomatis aktif
      home: const SplashScreen(), // tetap mulai dari splash
      getPages: [
        GetPage(name: '/signin', page: () => const SigninPage()),
        GetPage(name: '/register', page: () => const RegistePage()),
        GetPage(name: '/home', page: () => const HomeView()), // ✅ pakai GetX Home
        GetPage(name: '/bottomnav', page: () => const BottomNavScreen()),
        GetPage(name: '/leaderboard', page: () => const LeaderboardPage()),
      ],
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      // ✅ Ganti navigator biasa → GetX navigation
      Get.offAllNamed('/signin');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff947EED),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset('assets/logo fix.png', scale: 4)],
        ),
      ),
    );
  }
}
