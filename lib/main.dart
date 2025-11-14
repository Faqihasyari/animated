import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/bottomnav/bindings/bottomnav_binding.dart';
import 'package:flutter_application_1/app/modules/bottomnav/view/bottomnav_view.dart';
import 'package:flutter_application_1/app/modules/home/bindings/home_binding.dart';
import 'package:flutter_application_1/app/modules/leaderboard/bindings/leaderboard_binding.dart';
import 'package:flutter_application_1/app/modules/leaderboard/views/leaderboard_views.dart';
import 'package:flutter_application_1/app/modules/quiz/binding/quiz_binding.dart';
import 'package:flutter_application_1/app/modules/quiz/view/quiz_view.dart';
import 'package:flutter_application_1/app/modules/register/bindings/register_binding.dart';
import 'package:flutter_application_1/app/modules/register/views/register_view.dart';
import 'package:flutter_application_1/app/modules/result_page/bindings/result_binding.dart';
import 'package:flutter_application_1/app/modules/result_page/views/result_view.dart';
import 'package:flutter_application_1/app/modules/setting/binding/setting_binding.dart';
import 'package:flutter_application_1/app/modules/setting/view/setting_view.dart';
import 'package:flutter_application_1/app/modules/sign_in/bindings/signin_binding.dart';
import 'package:flutter_application_1/app/modules/sign_in/views/signin_view.dart';
import 'package:get/get.dart';

// Hapus import controller yang tidak perlu untuk manual put
import 'package:flutter_application_1/app/modules/home/views/home_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: HomeBinding(),
      home: const SplashScreen(),
      getPages: [
        GetPage(
          name: '/signin',
          page: () => const SigninView(),
          binding: SigninBinding(),
        ),
        GetPage(
          name: '/register',
          page: () => const RegisterView(),
          binding: RegisterBinding(),
        ),
        GetPage(
          name: '/home',
          page: () => const HomeView(),
          binding: HomeBinding(), // ✅ pindahkan binding ke sini
        ),
        GetPage(
          name: '/bottomnav',
          page: () => const BottomNavView(),
          binding: BottomNavBinding(),
        ),
        // ✅ TAMBAHKAN QuizView yang missing
        GetPage(
          name: '/quiz',
          page: () => const QuizView(),
          binding: QuizBinding(), // Pastikan buat QuizBinding juga
        ),
        GetPage(
          name: '/result',
          page: () => const ResultPage(),
          binding: ResultBinding(), // Buat Binding untuk Result
        ),
        GetPage(
          name: '/leaderboard',
          page: () => const LeaderboardView(),
          binding: LeaderboardBinding(),
        ),
        GetPage(
          name: '/setting',
          page: () => SettingView(),
          binding: SettingBinding(),
        ),
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
      // ✅ Gunakan offAllNamed dengan proper route
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
