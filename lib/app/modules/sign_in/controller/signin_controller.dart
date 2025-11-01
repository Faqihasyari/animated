// lib/app/modules/signin/controller/signin_controller.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var obscurePassword = true.obs;
  var isLoading = false.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> login() async {
    try {
      isLoading.value = true;

      final res = await ApiService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        // 🔹 Ambil data user dan token dari response
        final userName = data['user']['name'];
        final token = data['token'];

        // 🔹 Simpan ke SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_name', userName);
        await prefs.setString('token', token);

        Get.snackbar(
          'Success',
          'Login berhasil!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // 🔹 Arahkan ke halaman utama
        Get.offAllNamed('/bottomnav');
      } else {
        Get.snackbar(
          'Error',
          data['message'] ?? 'Login gagal',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void goToRegister() {
    Get.toNamed('/register');
  }

  // @override
  // void onClose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.onClose();
  // }
}
