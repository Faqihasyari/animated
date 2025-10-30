import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/bottomnav/bindings/bottomnav_binding.dart';
import 'package:flutter_application_1/app/modules/bottomnav/controller/bottomnav_controller.dart';
import 'package:flutter_application_1/app/modules/bottomnav/view/bottomnav_view.dart';
import 'package:flutter_application_1/app/modules/home/controller/home_controller.dart';
import 'package:flutter_application_1/app/modules/leaderboard/controller/leaderboard_controller.dart';
import 'package:flutter_application_1/app/modules/leaderboard/views/leaderboard_views.dart';
import 'package:get/get.dart'; // ✅ tambahkan ini

import 'package:flutter_application_1/SignIn_page.dart';
import 'package:flutter_application_1/registe_page.dart';

// kalau sudah buat folder GetX (controllers, views, bindings)
import 'package:flutter_application_1/app/modules/home/bindings/home_binding.dart';
import 'package:flutter_application_1/app/modules/home/views/home_view.dart';

void main() {
  Get.put(HomeController());
  Get.put(LeaderboardController());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // ✅ ubah dari MaterialApp → GetMaterialApp
      debugShowCheckedModeBanner: false,
      initialBinding: HomeBinding(), // ✅ supaya controller otomatis aktif
      home: const SplashScreen(), // tetap mulai dari splash
      getPages: [
        GetPage(name: '/signin', page: () => const SigninPage()),
        GetPage(name: '/register', page: () => const RegistePage()),
        GetPage(
          name: '/home',
          page: () => const HomeView(),
        ), // ✅ pakai GetX Home
        GetPage(
          name: '/bottomnav',
          page: () => const BottomNavView(),
          binding: BottomNavBinding(),
        ),
        GetPage(name: '/leaderboard', page: () => const LeaderboardView()),
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
