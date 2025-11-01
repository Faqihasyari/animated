// lib/app/modules/signin/bindings/signin_binding.dart
import 'package:get/get.dart';
import '../controller/signin_controller.dart';

class SigninBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SigninController>(() => SigninController());
  }
}