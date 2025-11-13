// app/modules/setting/binding/setting_binding.dart
import 'package:get/get.dart';
import '../controller/view_controller.dart'; // Pastikan import path benar

class SettingBinding implements Bindings {
  @override
  void dependencies() {
    print('🔄 SettingBinding initialized'); // Debug
    Get.lazyPut<LogoutController>(() => LogoutController(), fenix: true);
  }
}