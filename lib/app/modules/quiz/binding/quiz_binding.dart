import 'package:flutter_application_1/app/modules/quiz/controller/quiz_controller.dart';
import 'package:get/get.dart';

class QuizBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuizController>(() => QuizController());
  }
}
