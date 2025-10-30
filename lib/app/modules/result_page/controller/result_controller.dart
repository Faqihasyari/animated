import 'package:get/get.dart';

class ResultController extends GetxController {
  var correctAnswers = 0.obs;
  var totalQuestions = 0.obs;
  var userName = ''.obs;
  var userRank = 0.obs;

  // Fungsi untuk set data hasil kuis
  void setResult({
    required int correct,
    required int total,
    required String name,
    required int rank,
  }) {
    correctAnswers.value = correct;
    totalQuestions.value = total;
    userName.value = name;
    userRank.value = rank;
  }
}
