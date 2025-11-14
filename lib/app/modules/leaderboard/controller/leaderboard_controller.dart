import 'package:get/get.dart';

class LeaderboardController extends GetxController {
  var selectedIndex = 0.obs;
  

  // Fungsi untuk mengganti tab
  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
