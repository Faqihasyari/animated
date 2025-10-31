import 'package:get/get.dart';

class ResultController extends GetxController {
  var correctAnswers = 0.obs;
  var totalQuestions = 0.obs;
  var userName = ''.obs;
  var userRank = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadResultData();
  }

  void _loadResultData() {
    // ✅ Ambil data dari arguments instead of manual set
    final arguments = Get.arguments;
    if (arguments != null && arguments is Map) {
      correctAnswers.value = arguments['correctAnswers'] ?? 0;
      totalQuestions.value = arguments['totalQuestions'] ?? 0;
      userName.value = arguments['userName'] ?? 'User';
      userRank.value = arguments['userRank'] ?? 0;
    }
  }

  // Hapus method setResult karena tidak perlu lagi
  // Data akan di-pass melalui arguments
}