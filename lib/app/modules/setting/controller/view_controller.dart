// app/modules/setting/controller/logout_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutController extends GetxController {
  final isLoading = false.obs;

  Future<void> logout() async {
    try {
      isLoading.value = true;

      // Debug: print sebelum clear
      print('🔄 Starting logout process...');

      // Clear shared preferences dengan error handling
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        print('✅ SharedPreferences cleared successfully');
      } catch (e) {
        print('❌ Error clearing SharedPreferences: $e');
        // Lanjutkan proses walaupun ada error di shared preferences
      }

      // Delay sedikit untuk memastikan proses clear selesai
      await Future.delayed(Duration(milliseconds: 100));

      // Navigate to login page
      print('🔄 Navigating to login page...');
      Get.offAllNamed('/signin');

      print('✅ Logout completed successfully');
    } catch (e, stackTrace) {
      // Print error detail dengan stack trace
      print('❌ Logout error: $e');
      print('📋 Stack trace: $stackTrace');

      Get.snackbar(
        'Error',
        'Failed to logout: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void showLogoutConfirmation() {
    Get.dialog(
      AlertDialog(
        title: Text('Konfirmasi Logout'),
        content: Text('Apakah Anda yakin ingin logout?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('Batal')),
          TextButton(
            onPressed: () {
              Get.back();
              logout();
            },
            child: Obx(
              () => isLoading.value
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ),
        ],
      ),
    );
  }
}
