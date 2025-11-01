// lib/app/modules/register/bindings/register_binding.dart
import 'package:get/get.dart';
import '../controller/register_controller.dart';

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}