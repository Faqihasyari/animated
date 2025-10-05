import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/color.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:google_fonts/google_fonts.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  void login() async {
    setState(() => isLoading = true);

    final res = await ApiService.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    if (!mounted) return; // ✅ tambahkan ini biar aman
    setState(() => isLoading = false);

    final data = jsonDecode(res.body);

    if (res.statusCode == 200) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Login berhasil!")));

      // 🔹 Ganti halaman, tidak bisa kembali ke login lagi
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyQuiz()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(data['message'] ?? 'Login gagal')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, // mulai dari atas
            end: Alignment.bottomCenter, // berakhir di bawah
            colors: [
              gradient1, // warna atas
              gradient2, // warna bawah
              gradient3,
              gradient4,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40),
          child: Center(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // ⬅️ horizontal tengah
              children: [
                Image.asset('assets/SignIn.png', scale: 2),
                Text(
                  'Sign In',
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 270,
                  height: 40,
                  child: Text(
                    'Masukkan email & password untuk mengakses akun kamu',
                    style: TextStyle(color: subtitle),
                    textAlign: TextAlign.center,
                  ),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'Email',
                    hintStyle: GoogleFonts.poppins(
                      color: subtitle,
                      fontSize: 12,
                    ),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'Email',
                    hintStyle: GoogleFonts.poppins(
                      color: subtitle,
                      fontSize: 12,
                    ),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isLoading ? null : login,
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
