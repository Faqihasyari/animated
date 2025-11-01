// lib/app/modules/register/controller/register_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter_application_1/services/api_service.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  
  var obscurePassword = true.obs;
  var obscureConfirmPassword = true.obs;
  var isChecked = false.obs;
  var isLoading = false.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  void toggleAgreement() {
    isChecked.value = !isChecked.value;
  }

  Future<void> register() async {
    try {
      // Validasi password match
      if (passwordController.text != confirmPasswordController.text) {
        Get.dialog(
          AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text('Password Tidak Sama', textAlign: TextAlign.center),
            content: const Text(
              'Pastikan password dan konfirmasi password kamu sama sebelum melanjutkan.',
              textAlign: TextAlign.center,
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("OK"),
              ),
            ],
          ),
        );
        return;
      }

      // Validasi agreement
      if (!isChecked.value) {
        Get.snackbar(
          'Error',
          'Anda harus menyetujui persyaratan',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      isLoading.value = true;

      final response = await ApiService.register(
        nameController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Anda Telah Berhasil Membuat Akun JDquizz',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        
        // Redirect ke login page setelah registrasi berhasil
        Future.delayed(const Duration(seconds: 2), () {
          Get.offAllNamed('/signin');
        });
      } else {
        final errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          errorData['message'] ?? 'Registrasi gagal',
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

  void goToTerms() {
    // TODO: Implement terms page navigation
    print("Terms clicked!");
  }

  void goToLogin() {
    Get.offAllNamed('/signin');
  }

  // ✅ HAPUS onClose() - Biarkan GetX handle disposal
}