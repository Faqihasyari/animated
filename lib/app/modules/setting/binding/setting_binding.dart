// app/modules/auth/binding/logout_binding.dart
import 'package:flutter_application_1/app/modules/setting/controller/view_controller.dart';
import 'package:get/get.dart';

class SettingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogoutController>(() => LogoutController());
  }
}